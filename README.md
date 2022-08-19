# Final Project Oprec MCI 2022
  
## Foodcourt Service App
Aplikasi ini untuk melayani pemesanan makanan di Foodcourt

## Fitur Aplikasi
List fitur pada aplikasi ini adalah sebagai berikut.
1. Menampilkan dan menyimpan daftar pesanan yang berlangsung
2. Menampilkan dan menyimpan daftar transaksi yang telah selesai
3. Menampilkan dan menyimpan data Tenant (Kios) yang berjualan di Foodcourt
4. Menyimpan daftar menu makanan
5. Mengedit makanan oleh Tenant
6. Melihat menu makanan yang tersedia di Foodcourt oleh Customer
7. Melakukan pemesanan makanan oleh Customer
8. Melihat daftar antrian pesanan oleh Tenant
9. Melihat history pesanan yang telah selesai

## Tampilan Aplikasi
(screenshot fitur aplikasi)
### Fitur 1: Menampilkan dan menyimpan daftar pesanan yang berlangsung
Tampilan berikut merupakan view di sisi Kasir. Kasir dapat melihat daftar pesanan yang berlangsung berisi nama Customer, total biaya yang harus dibayar, dan kondisi apakah Customer sudah membayar, ataupun kondisi apakah makanan pesanan customer sudah selesai.
</br>
</br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185619331-118a9bc9-6e30-4fe0-b7e7-816e8b6e748a.png">
</br>
Gambar di atas juga terdapat tombol Done yaitu untuk mengatur status Paid. Kasir menekan tombol tersebut jika Customer telah melakukan pembayaran di kasir

### Fitur 2: Menampilkan dan menyimpan daftar transaksi yang telah selesai
Transaksi yang sudah dibayar dan makanan sudah diantar, maka transaksi akan ditampilkan di tampilan History di sisi Kasir
</br>
</br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185621186-bf06c945-0d47-412a-a9f9-3fe912bed760.png">

### Fitur 3: Menampilkan dan menyimpan data Tenant (Kios) yang berjualan di Foodcourt
Di sisi kasir dapat melihat daftar Tenant yang berjualan di Foodcourt.
</br></br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185621537-aebd3e95-28da-4185-b57b-5765308f5c5b.png">
</br>
Kasir juga dapat menambahkan Tenant baru jika ingin berjualan di Foodcourt.
</br></br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185621788-7bcc0808-2db4-4fa1-b97a-689bdd7f038d.png">
</br>
Selain itu Kasir juga dapat mengedit data Tenant
</br></br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185622008-161c7b5c-fa9e-4869-8989-0b87204a4c71.png">
</br>

### Fitur 4: Menyimpan daftar menu makanan
Tenant log in dengan username dan password yang telah didaftarkan oleh Kasir
</br></br>
<img width="197" alt="image" src="https://user-images.githubusercontent.com/87472849/185624221-affb6c06-616b-4760-99c4-17aa668124ba.png">
</br>
Tampilan halaman utama di aplikasi Tenant seperti berikut
</br></br>
<img width="198" alt="image" src="https://user-images.githubusercontent.com/87472849/185624671-1b73bf10-e5a3-45cf-8aca-9fb9d205110f.png">
</br>
Jika Tenant menekan New Menu, maka akan menuju halaman Add New Menu
</br></br>
<img width="200" alt="image" src="https://user-images.githubusercontent.com/87472849/185624870-b1c83ada-3f27-4034-9b88-bc0530196ddb.png">
</br>

### Fitur 5: Mengedit makanan oleh Tenant
Jika Tenant menekan Menu, maka akan menuju halaman All Menu yang menampilkan daftar makananyang dijual Tenant tersebut
</br></br>
<img width="200" alt="image" src="https://user-images.githubusercontent.com/87472849/185625154-7ef58cbc-4f44-4e37-abab-5d32da95a4d6.png">
</br>
Jika menekan list menu tersebut, maka akan menuju halaman Edit Menu
</br></br>
<img width="200" alt="image" src="https://user-images.githubusercontent.com/87472849/185625398-072f5e70-ce91-4b2a-9f91-0cbc4809e388.png">
</br>

### Fitur 6: Melihat menu makanan yang tersedia di Foodcourt oleh Customer
Customer akan menggunakan aplikasi yang berbeda. Tampilan ketika Customer membuka aplikasi adalah sebagai berikut.
</br></br>
<img width="196" alt="image" src="https://user-images.githubusercontent.com/87472849/185628468-2fce67d6-e947-4e4d-b4ca-b91297c3fd4a.png">
<img width="200" alt="image" src="https://user-images.githubusercontent.com/87472849/185631742-0995fc81-bbba-4a8c-a675-0ff24fb04f42.png">
</br>
Customer Juga dapat melihat Detail makanan jika menekan kartu menu
</br></br>
<img width="201" alt="image" src="https://user-images.githubusercontent.com/87472849/185631876-85a6a00e-426a-414c-b97a-04a5f22fbe85.png">
</br>

### Fitur 7: Melakukan pemesanan makanan oleh Customer
Customer dapat memesan makanan yang diinginkan dengan memenekan tombol Order dan juga dapat mengatur jumlah yang dipesan
</br></br>
<img width="198" alt="image" src="https://user-images.githubusercontent.com/87472849/185632057-b154e11e-1721-41e2-8539-129d94791d6d.png">
</br>
Jika Customer menekan tombol checkout, maka akan menuju halaman Checkout seperti berikut.
</br></br>
<img width="199" alt="image" src="https://user-images.githubusercontent.com/87472849/185630525-b4cd3821-6afb-404c-b5bf-69d4a0038f40.png">
</br>
Dengan checkout tersebut, Customer memasukkan nama dan dapat menulis catatan jika perlu. Customer juga dapat memilih metode pembayaran. Jika Customer memilih Cashier, maka status Paid akan 'unpaid' di layar Kasir dan pesanan Customer tersebut belum muncul di halaman Queue Tenant hingga Customer membayar tagihan pesanan.
</br>

### Fitur 8: Melihat daftar antrian pesanan oleh Tenant
Seperti yang terjadi di atas, Sofyan memilih pembayaran cash di kasir. Maka Sofyan harus membayar terlebih dahulu agar Tenant dapat nenyiapkan pesanan Sofyan. Berikut adalah tampilan layar kasir
</br></br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185633761-5851d8de-f066-4bca-ae45-d453fc3e6c2b.png">
</br>
Setelah Sofyan selesai membayar pesanannya, maka Kasir akan menekan tombol Done untuk pesanan Sofyan. Sehingga status pesanan Sofyan menjadi "paid" dan pesanannya akan masuk di Queue aplikasi Tenant.
</br></br>
<img width="960" alt="image" src="https://user-images.githubusercontent.com/87472849/185634218-ad724e81-b194-470a-a2d9-d44c9013ec05.png">
</br>
Sekarang pesanan Sofyan sudah muncul di aplikasi Tenant. Karena Sofyan memesan makanan di dua Tenant yang berbeda, maka pesanan Sofyan muncul di kedua Tenant dengan masing-masing makanan yang dijual oleh Tenant.
</br></br>
<img width="199" alt="image" src="https://user-images.githubusercontent.com/87472849/185637129-ed27de8b-5dd0-449b-b5df-585ffc08098c.png">
<img width="199" alt="image" src="https://user-images.githubusercontent.com/87472849/185637341-6147ef6d-6812-4abb-9898-b9057e010507.png">


9. Melihat history pesanan yang telah selesai

## Desain Database
Database pada Foodcourt Servics App ini memiliki 4 tabel dan relasi sebagai berikut
</br></br>
<img width="349" alt="image" src="https://user-images.githubusercontent.com/87472849/185650510-7fbe3fca-fa92-4017-a136-4c2178261fcf.png">


