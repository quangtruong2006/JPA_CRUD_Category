<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tất cả sản phẩm - Shopping Store</title>
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	background-color: #f1f5f9;
}

.product-card {
	background: #ffffff;
	border-radius: 15px;
	border: 1px solid #e2e8f0;
	overflow: hidden;
	transition: all 0.3s ease;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 20px rgba(0, 119, 255, 0.15);
	border-color: #93c5fd;
}

.product-img-wrapper {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #f8fafc;
	overflow: hidden;
}

.product-img-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform 0.3s ease;
}

.product-card:hover .product-img-wrapper img {
	transform: scale(1.1);
}

.product-price {
	color: #ef4444;
	font-size: 1.1rem;
	font-weight: 800;
}
</style>
</head>
<body>



	<div class="container pb-5">

		<!-- NÚT QUAY LẠI -->
		<div class="mb-4">
			<a href="${pageContext.request.contextPath}/home"
				class="btn btn-outline-secondary fw-bold"> <i
				class="bi bi-arrow-left me-1"></i> Quay lại trang chủ
			</a>
		</div>

		<h2 class="fw-bold mb-4" style="color: #0f172a;">
			<!-- GRID SẢN PHẨM -->
			<div class="row row-cols-1 row-cols-md-3 row-cols-lg-3 g-4 mb-5">
				<c:forEach items="${listP}" var="p">
					<div class="col">
						<div class="product-card h-100 d-flex flex-column">
							<div class="product-img-wrapper">
								<img src="${pageContext.request.contextPath}/uploads/${p.image}"
									alt="${p.productName}">
							</div>
							<div class="p-3 d-flex flex-column flex-grow-1">
								<h6 class="fw-bold text-dark mb-2"
									style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
									${p.productName}</h6>
								<p class="product-price mt-auto mb-3">${p.price}VNĐ</p>
								<a
									href="${pageContext.request.contextPath}/product/detail?id=${p.productId}&from=product&index=${tag}"
									class="btn btn-outline-primary w-100 fw-bold"> <i
									class="bi bi-eye"></i> Xem
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- THANH PHÂN TRANG (PAGINATION) - ĐÃ ĐỔI SANG /product -->
			<nav aria-label="Page navigation">
				<ul class="pagination justify-content-center pagination-lg">

					<!-- Chạy vòng lặp từ trang 1 đến tổng số trang (endP) -->
					<c:forEach begin="1" end="${endP}" var="i">
						<!-- Nếu trang hiện tại (tag) bằng i thì tô màu xanh (active) -->
						<li class="page-item ${tag == i ? 'active' : ''}"><a
							class="page-link fw-bold"
							href="${pageContext.request.contextPath}/product?index=${i}">${i}</a>
						</li>
					</c:forEach>

				</ul>
			</nav>
	</div>

</body>
</html>