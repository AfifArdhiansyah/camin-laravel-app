<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <title>Add New Tenant</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-5">
            <a class="btn btn-success" href="/">Back</a>
            <h2 class="mb-5 text-center">Add New Tenant</h2>
            <form action="store-tenant" method="POST">
                @csrf
                <div class="form-group">
                    <label for="name">Nama Tenant</label>
                    <input type="text" class="form-control" name="name" placeholder="Masukkan nama tenant.." required>
                </div>
                <div class="form-group">
                    <label for="name">Username Tenant</label>
                    <input type="text" class="form-control" name="username" placeholder="Masukkan username tenant.." required>
                </div>
                <div class="form-group">
                    <label for="name">Password Tenant</label>
                    <input type="text" class="form-control" name="password" placeholder="Masukkan password tenant.." required>
                </div>
                <div class="d-flex justify-content-end">
                    <button type="submit" class="btn btn-md btn-success">Submit</button>
                </div>                
            </form>
        </div>
        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>