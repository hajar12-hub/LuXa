package com.luxa.ecommerce.controller;

import java.io.IOException;
import java.util.Optional;
import java.util.stream.Collectors;

import com.luxa.ecommerce.dao.impl.ProductDAOImpl;
import com.luxa.ecommerce.dao.interfaces.ProductDAO;
import com.luxa.ecommerce.dto.ProductDetailDto;
import com.luxa.ecommerce.dto.ProductImageDto;
import com.luxa.ecommerce.dto.ProductVariantDto;
import com.luxa.ecommerce.model.Product;
import com.luxa.ecommerce.util.JsonUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/api/products/*")
public class ProductDetailServlet extends HttpServlet {

    private ProductDAO productDao;

    @Override
    public void init() throws ServletException {
        this.productDao = new ProductDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du produit manquant dans l'URL.");
            return;
        }

        try {
            Integer productId = Integer.parseInt(pathInfo.substring(1));
            Optional<Product> productOptional = productDao.findById(productId);

            if (productOptional.isPresent()) {
                Product product = productOptional.get();
                ProductDetailDto dto = convertToDetailDto(product);
                String jsonResponse = JsonUtil.toJson(dto);
                resp.getWriter().write(jsonResponse);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Produit non trouvé pour l'ID " + productId);
            }

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID du produit invalide : " + pathInfo.substring(1));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur.");
        }
    }

    private ProductDetailDto convertToDetailDto(Product product) {
        ProductDetailDto dto = new ProductDetailDto();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setDescription(product.getDescription());

        if (product.getPrice() != null) {
            dto.setPrice(product.getPrice().doubleValue());
        }

        dto.setStockQuantity(product.getStockQuantity());

        if (product.getCategory() != null) {
            dto.setCategoryName(product.getCategory().getName());
        }

        dto.setImages(product.getImages().stream().map(img -> {
            ProductImageDto imgDto = new ProductImageDto();
            imgDto.setId(img.getId());
            imgDto.setUrl(img.getUrl());
            imgDto.setMain(img.getMain() != null && img.getMain());
            return imgDto;
        }).collect(Collectors.toList()));

        dto.setVariants(product.getVariants().stream().map(var -> {
            ProductVariantDto varDto = new ProductVariantDto();
            varDto.setId(var.getId());
            varDto.setName(var.getName());
            varDto.setSku(var.getSku());
            varDto.setPrice(var.getPrice());
            varDto.setStockQuantity(var.getStockQuantity());
            return varDto;
        }).collect(Collectors.toList()));

        return dto;
    }
}