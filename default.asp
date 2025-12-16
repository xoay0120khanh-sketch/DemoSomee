<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>📚 Quản Lý Sách</title>

    <!-- 🎨 Bootstrap (UI framework) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f5f7fa;
        }
        .container {
            max-width: 900px;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <!-- 🏷️ Tiêu đề -->
    <h2 class="text-center text-primary mb-4">📚 Quản Lý Sách (Frontend)</h2>

    <!-- ✏️ Form nhập sách -->
    <div class="card mb-4">
        <div class="card-header bg-success text-white">➕ Thêm / Cập nhật sách</div>
        <div class="card-body">
            <input type="hidden" id="bookIndex">

            <div class="row mb-3">
                <div class="col">
                    📖 <label>Tên sách</label>
                    <input type="text" id="title" class="form-control">
                </div>
                <div class="col">
                    ✍️ <label>Tác giả</label>
                    <input type="text" id="author" class="form-control">
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    🏷️ <label>Thể loại</label>
                    <input type="text" id="category" class="form-control">
                </div>
                <div class="col">
                    📅 <label>Năm xuất bản</label>
                    <input type="number" id="year" class="form-control">
                </div>
            </div>

            <button class="btn btn-success" onclick="saveBook()">💾 Lưu sách</button>
            <button class="btn btn-secondary" onclick="resetForm()">♻️ Làm mới</button>
        </div>
    </div>

    <!-- 📋 Danh sách sách -->
    <div class="card">
        <div class="card-header bg-primary text-white">📋 Danh sách sách</div>
        <div class="card-body">
            <table class="table table-bordered text-center">
                <thead class="table-light">
                    <tr>
                        <th>#</th>
                        <th>📖 Tên sách</th>
                        <th>✍️ Tác giả</th>
                        <th>🏷️ Thể loại</th>
                        <th>📅 Năm</th>
                        <th>⚙️ Thao tác</th>
                    </tr>
                </thead>
                <tbody id="bookTable"></tbody>
            </table>
        </div>
    </div>
</div>

<!-- 🧠 JavaScript -->
<script>
    let books = JSON.parse(localStorage.getItem("books")) || [];

    function renderBooks() {
        const table = document.getElementById("bookTable");
        table.innerHTML = "";

        books.forEach((b, i) => {
            table.innerHTML += `
                <tr>
                    <td>${i + 1}</td>
                    <td>${b.title}</td>
                    <td>${b.author}</td>
                    <td>${b.category}</td>
                    <td>${b.year}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editBook(${i})">✏️</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteBook(${i})">🗑️</button>
                    </td>
                </tr>
            `;
        });
    }

    function saveBook() {
        const title = document.getElementById("title").value;
        const author = document.getElementById("author").value;
        const category = document.getElementById("category").value;
        const year = document.getElementById("year").value;
        const index = document.getElementById("bookIndex").value;

        if (!title || !author) {
            alert("⚠️ Vui lòng nhập đầy đủ thông tin");
            return;
        }

        const book = { title, author, category, year };

        if (index === "") {
            books.push(book);
        } else {
            books[index] = book;
        }

        localStorage.setItem("books", JSON.stringify(books));
        resetForm();
        renderBooks();
    }

    function editBook(index) {
        const b = books[index];
        document.getElementById("title").value = b.title;
        document.getElementById("author").value = b.author;
        document.getElementById("category").value = b.category;
        document.getElementById("year").value = b.year;
        document.getElementById("bookIndex").value = index;
    }

    function deleteBook(index) {
        if (confirm("🗑️ Xóa sách này?")) {
            books.splice(index, 1);
            localStorage.setItem("books", JSON.stringify(books));
            renderBooks();
        }
    }

    function resetForm() {
        document.getElementById("title").value = "";
        document.getElementById("author").value = "";
        document.getElementById("category").value = "";
        document.getElementById("year").value = "";
        document.getElementById("bookIndex").value = "";
    }

    renderBooks();
</script>

</body>
</html>
