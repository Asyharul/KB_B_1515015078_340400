PREDICATES
  nondeterm peran(symbol)
  nondeterm adalah(symbol, symbol)
  ambil(symbol,symbol)
  nondeterm siapa_malingnya(symbol)- nondeterm (o)
  bukti(symbol,symbol)

CLAUSES

  %ceritanya di kampus ada 3 peran, yaitu mahasiswa, maling, dan satpam. Diprogram ini kita mencari siapa malingnya yang terbukti mengambil barang yang telah kita tentukan.
  peran(mahasiswa).
  peran(maling).
  peran(satpam).

  adalah(arul,mahasiswa).
  adalah(yopan,maling).
  adalah(katon,satpam).
  adalah(yahya,maling).
  adalah(galih,maling).
  adalah(andik,maling).
  
  ambil(arul,tidak).
  ambil(katon,tidak).
  ambil(yahya,mengaku).
  ambil(yopan,mengaku).
  ambil(andik,mengaku).
  ambil(galih,mengaku).
  
  bukti(arul,tidakada).
  bukti(katon,tidakada).
  bukti(yahya,laptop).
  bukti(yopan,helm).
  bukti(andik,handphone).
  bukti(galih,helm).

  siapa_malingnya(Y):-
  	peran(X), 
        adalah(Y,X),  	
        ambil(Y,mengaku),
        bukti(Y,helm).

GOAL
      siapa_malingnya(Malingnya).