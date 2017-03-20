 DOMAINS
  nama = symbol
  tinggi  = integer
  kg = integer
  berat = integer
  
PREDICATES
  nondeterm cowok_ideal(nama,tinggi,berat)
  nondeterm orang(nama, tinggi)
  nondeterm kg(nama, berat)

CLAUSES
  orang("Muhammad Asharul", 170).
  orang("Fajar Khairuman", 164).
  orang("Katon Nur Riyanto", 171).
  orang("Andre prasetya", 166).
  orang("Budi setyo", 170).

  kg("Muhammad Asharul", 51).
  kg("Fajar Khairuman", 40).
  kg("Katon Nur Riyanto", 55).
  kg("Andre prasetya", 150).
  kg("Budi setyo", 70).
  
  cowok_ideal(Nama,Tinggi,Berat):-
      orang(Nama, Tinggi),
      Tinggi>=166,
      kg(Nama,Berat),
      Berat>50,
      Berat<60.

GOAL
  write("Jadi cowok ideal dan idaman itu adalah : "),nl, cowok_ideal(Nama,Tinggi,Berat).