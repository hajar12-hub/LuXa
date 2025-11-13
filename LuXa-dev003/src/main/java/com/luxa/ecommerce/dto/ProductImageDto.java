package com.luxa.ecommerce.dto;

public class ProductImageDto {
    private Integer id;
    private String url;
    private boolean isMain;

    public ProductImageDto() {}


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public boolean isMain() {
        return isMain;
    }

    public void setMain(boolean isMain) {
        this.isMain = isMain;
    }
}
