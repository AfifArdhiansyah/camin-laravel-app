<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <title>Foodcourt Cashier</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-success px-5">
            <a class="navbar-brand" href="#">Foodcourt</a>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/">Transaksi</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/history">History</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/tenant">Tenant</a>
                </li>
            </ul>
        </nav>
        <div class="p-3">
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Id</th>
                        <th scope="col">Name</th>
                        <th scope="col">Total</th>
                        <th scope="col">Paid</th>
                        <th scope="col">Served</th>
                        <th scope="col">Time</th>
                      </tr>
                </thead>
                <tbody>
                    @forelse ($transactions as $transaction)
                        @if($transaction->paid == 1 && $transaction->served == 1)
                        <tr>
                            <th scope="row" class="align-middle">{{ $transaction->id }}</th>
                            <td class="align-middle">{{ $transaction->name }}</td>
                            <td class="align-middle">{{ $transaction->total }}</td>
                            <td class="align-middle">
                                <div class="text-success">Done</div>
                            </td>
                            <td class="align-middle">
                                <div class="text-success">Served</div>
                            </td>
                            <td class="align-middle">
                                {{ $transaction->updated_at }}
                            </form>
                            </td>
                        </tr>
                        @endif
                    @empty
                    <li class="list-group-item">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4>Data tidak ada</h4>
                        </div>
                    </li>
                    @endforelse                   
                </tbody>
            </table>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>
</html>