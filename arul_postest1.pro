PREDICATES
  nondeterm jenis(symbol, symbol)
  nondeterm adalah(symbol, symbol)
  hidup(symbol, symbol)
  nondeterm bisa_terbang(symbol)

CLAUSES
  jenis(mamalia,hewan).
  jenis(burung,hewan).
  jenis(ikan,hewan).

  adalah(zebra,mamalia).
  adalah(elang,burung).
  adalah(tuna,ikan).
  adalah(gagak,aves).

  hidup(zebra,di_darat).
  hidup(elang,di_udara).
  hidup(lele,di_air).
  hidup(babi,di_air).
  hidup(gagak,darat).

  bisa_terbang(Y):-       %subgoal
      jenis(X,hewan),
      adalah(Y,X),
      hidup(Y,di_udara).

GOAL
      bisa_terbang(Apa).
      
%alur program.....
%Program memanggil predikat bisa_terbang dengan variabel bebas Apa. Untuk menjawab panggilan ini, sistem mencari di program untuk pencocokan. 
%Ditemukan kecocokan dengan klausa bisa_terbang, dan variabel Apa dijadikan dengan variabel Y untuk menampilkan nama hewannya.
%Untuk melakukannya, Visual Prolog memanggil subgoal yang pertama  yaitu jenis(X, hewan),
%dibagian pertama klausa jenis ada mamalia, maka program akan mengambil mamalia untuk dilnjutkan ke klausa "adalah",
%dibagian klausa "adalah" program akan mengambil zebra karena cuma zebra yang mamalia,
%setelah itu program akan lanjut ke klausa hidup dan mengambil zebra untuk dibawa ke goal, karena di subgoal yang dicari "di_udara" maka zebra batal dibawa ke goal,
%program akan mengulang kembali dari atas sampai menemukan jawaban dari subgoal yang harus (Y,di_udara),
%karena dibagian kedua di klausa jenis adalah burung maka program akan lanjut ke bagian klausa "adalah", disitu ada elang karena X nya tadi burung.
%setelah itu elang dibawa ke klausa hidup dan elang sudah sesuai sama subgoalnya (Y,di_udara),jadi program sudah menemukan jawabannya dan bisa dibawa ke Goal untuk output,
%karena jawaban yang betul cuman elang jadi program cuma menampilkan elang sebagai hasil output akhir.
% Variabel X untuk burung dan Variabel Y untuk Elang.
%selesai
