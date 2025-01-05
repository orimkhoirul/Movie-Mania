<%-- 
    Document   : AddMovie
    Created on : Jan 5, 2025, 11:04:55 PM
    Author     : acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Movie Data Form</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />
    <style>
        /* Styling code */
        body {
            width: 100%;
            height: 100vh;
            border-radius: 53px;
            background-image: url('/image/bgAdd.jpeg');
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: "Poppins";
        }
        .form-container {
            width: 75%;
            padding: 2rem;
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: bold;
        }
        .form-floating {
            margin-bottom: 1rem;
            background-color: #e5d4fc;
        }
        .form-control {
            background-color: #e5d4fc;
        }
        .submit-btn {
            display: flex;
            justify-content: center;
            margin-top: 1.5rem;
        }
        .submit-btn button {
            padding: 0.6rem 1.5rem;
            font-size: 1rem;
            background-color: rgb(138, 74, 222);
            background-image: linear-gradient(90deg, rgba(145, 129, 244, 1), rgba(80, 56, 237, 1));
            color: white;
            border-radius: 10px;
            font-weight: 700;
            border: none;
        }
        .file-upload-container {
            display: flex;
            justify-content: space-between;
            background-color: #ded1f2;
            border-radius: 15px;
            padding: 0.8rem;
            width: 100%;
        }
        .file-upload-container input[type="file"] {
            border: none;
            background-color: transparent;
            color: #f7f7f7;
            width: 0%;
        }
        .file-upload-container label {
            color: #4c3a74;
            font-size: 1rem;
        }
        .upload-icon {
            background-color: #4c3a74;
            border: none;
            border-radius: 50%;
            padding: 0.75rem;
            margin-left: 1rem;
            cursor: pointer;
            color: white;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>MASUKAN DATA FILM</h2>
        <form action="/MoviesController" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="addMovie">

    <!-- Judul -->
    <div class="form-floating mb-3 rounded-4">
        <input type="text" class="form-control rounded-4" id="judul" name="judul" placeholder="Judul" maxlength="100" required />
        <label for="judul">Judul</label>
    </div>

    <!-- Genre -->
    <div class="form-floating mb-3 rounded-4">
        <input type="text" class="form-control rounded-4" id="genre" name="genre" placeholder="Genre" maxlength="50" required />
        <label for="genre">Genre</label>
    </div>

    <!-- Description -->
    <div class="form-floating mb-3 rounded-4">
        <input type="text" class="form-control rounded-4" id="description" name="description" placeholder="Description" maxlength="255" />
        <label for="description">Description</label>
    </div>

    <!-- Release Date-->
    <div class="form-floating mb-3 rounded-4">
        <input type="date" class="form-control rounded-4" id="date" name="date" placeholder="Release Date" max="<?= date('Y-m-d') ?>" required />
        <label for="date">Tanggal Rilis</label>
    </div>

    <!-- Upload Poster -->
    <div class="file-upload-container">
        <span class="input-text start">Upload Poster</span>
        <input type="file" id="uploadPoster" name="poster" placeholder="Upload poster..." accept="image/*" required />
        <label for="uploadPoster">
            <img src="/image/upload.jpeg" style="width: 2rem; height: 2rem" />
        </label>
    </div>

    <!-- Add Movie Button -->
    <div class="submit-btn">
        <button type="submit" class="btn btn-primary">Add Movie</button>
    </div>
</form>

    </div>
    
    <script>
    document.querySelector('form').addEventListener('submit', function (event) {
        // Validasi judul (harus diisi)
        const judul = document.getElementById('judul').value.trim();
        if (!judul) {
            alert("Judul film harus diisi!");
            event.preventDefault();
        }

        // Validasi genre
        const genre = document.getElementById('genre').value.trim();
        if (!genre || genre.length > 50) {
            alert("Genre tidak boleh kosong dan maksimal 50 karakter.");
            event.preventDefault();
        }

        // Validasi deskripsi
        const description = document.getElementById('description').value.trim();
        if (description.length > 255) {
            alert("Deskripsi maksimal 255 karakter.");
            event.preventDefault();
        }

        // Validasi tanggal
        const date = document.getElementById('date').value;
        if (!date || new Date(date) > new Date()) {
            alert("Tanggal rilis harus diisi dan tidak boleh melebihi tanggal hari ini.");
            event.preventDefault();
        }

        // Validasi file upload
        const poster = document.getElementById('uploadPoster').files[0];
        if (!poster || !poster.type.startsWith('image/')) {
            alert("Harap unggah file gambar sebagai poster.");
            event.preventDefault();
        }
    });
</script>


    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>

