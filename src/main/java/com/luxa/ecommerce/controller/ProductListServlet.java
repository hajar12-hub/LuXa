package com.luxa.ecommerce.controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dto.ProductListDto;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.model.ProductImage;
import com.luxa.ecommerce.util.JsonUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/products")
public class ProductListServlet extends HttpServlet {

    private ProductDAO productDao;

    @Override
    public void init() throws ServletException {
        this.productDao = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String categoryIdStr = req.getParameter("category");
            String keyword = req.getParameter("q");
            String minPriceStr = req.getParameter("minPrice");
            String maxPriceStr = req.getParameter("maxPrice");

            Integer categoryId = null;
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    // Ignorer le paramètre s'il n'est pas un nombre valide
                }
            }

            Double minPrice = null;
            if (minPriceStr != null && !minPriceStr.isEmpty()) {
                try {
                    minPrice = Double.parseDouble(minPriceStr);
                } catch (NumberFormatException e) {
                    // Ignorer
                }
            }

            Double maxPrice = null;
            if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(maxPriceStr);
                } catch (NumberFormatException e) {
                    // Ignorer
                }
            }

            List<Product> products = productDao.search(categoryId, keyword, minPrice, maxPrice);

            List<ProductListDto> productDtos = products.stream()
                    .map(this::convertToDto)
                    .collect(Collectors.toList());

            String jsonResponse = JsonUtil.toJson(productDtos);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);

        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur lors de la récupération des produits.");
            e.printStackTrace();
        }
    }

    private ProductListDto convertToDto(Product product) {
        ProductListDto dto = new ProductListDto();
        dto.setId(product.getId());
        dto.setName(product.getName());

        if (product.getPrice() != null) {
            dto.setPrice(product.getPrice().doubleValue());
        }

        String mainImageUrl = product.getImages().stream()
                .filter(img -> img.getMain() != null && img.getMain())
                .findFirst()
                .map(ProductImage::getUrl)
                .orElse(product.getImages().isEmpty() ? null : product.getImages().get(0).getUrl());

        dto.setMainImageUrl(mainImageUrl);
        return dto;
    }
}