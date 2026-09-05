package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.*;

@Entity
@Table(name = "Products")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productId;

    @Column(columnDefinition = "NVARCHAR(255)")
    private String productName;

    private double price;

    @Column(columnDefinition = "NVARCHAR(500)")
    private String image; // Dùng để lưu tên file ảnh up lên

    @Column(columnDefinition = "NVARCHAR(MAX)")
    private String description;

    // Thiết lập mối quan hệ N-1 (Nhiều Sản phẩm thuộc 1 Danh mục)
    @ManyToOne
    @JoinColumn(name = "categoryId") 
    private Category category;

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

    // --- BẤM CHUỘT PHẢI -> Source -> Generate Getters and Setters CHO TẤT CẢ CÁC BIẾN NHÉ ---
    // (Ông tự generate ra cho đỡ dài code nhé)
    
}