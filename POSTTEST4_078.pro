trace
domains
  name,sex,occupation,object,vice,substance = symbol
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses                                    % Semua fakta tentang Pembunuhan
  person(bert,55,m,carpenter).      %orang-orangnya yang dicurigai
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

  had_affair(barbara,john).  %memiliki cemburu
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club).  %terbunuh dengan 
  killed(susan).

  motive(money).   %motifnya
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).  %ternodai
  smeared_in(susan,blood).
  smeared_in(allan,mud).
  smeared_in(john,chocolate).
  smeared_in(barbara,chocolate).

  owns(bert,wooden_leg).  %milik
  owns(john,pistol).

/* * * Background knowledge * * */                 % Latar belakang Pengetahuan

  operates_identically(wooden_leg, club).    %cara kerja pembunuhannya
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).

  owns_probably(X,football_boot):-   %kemungkinan yang punya barang tersebut
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *     %Curigai semua orang yang mempunyai senjata yang membuat susan terbunuh
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-       
	killed_with(susan,Weapon) ,  %mengecek senjatanya
	operates_identically(Object,Weapon) , %mengecek senjata yang bisa dipakai buat pentungan
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *      %curigai lelaki yang telah berselingkuh dengan susan
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(jealousy),  %motifnya cemburu
	person(X,_,m,_),  %prolog akan mengambil dan mengecek dibagian Person yang mempunyai variabel "m"
	had_affair(susan,X). %susan cemburu sama john

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *  %curigai cewek yang mempunyai cemburu dengan seseorang yang susan tau
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  * %curigai siapa yang mengambil uang
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(money),  %motifnya uang
	person(X,_,_,pickpocket). %prolog akan mengecek Person yang mempunyai variabel Pickpocket(john)

  killer(Killer):-     %ini sebagai unifikasi argumen
	person(Killer,_,_,_),  %sub goal kepertama 
	killed(Killed),    %subgoal kedua
	Killed <> Killer, /* It is not a suicide */ %Korban tidak Bunuh Diri
	suspect(Killer),   %subgoal ketiga
	smeared_in(Killer,Goo ),
	smeared_in(Killed,Goo).

goal
  killer(X ).
  
%ANALISIS

% X ini sebagai variabel bebas dapat di unifikasikan karena pembunuh juga variabel bebas dapat di unifikasi maka x=pembunuh
% pertama program akan mengecek data-data yang cocok dengan goal maka di temukan Killer(Killer):- sebagai unifikasi argument
% lalu program akan memanggil subgoal pertama maka ditemukan person(Killer,_,_,_),di temukan variable anonim ("_")
% variabel "_" berada di argumen "age,sex,occupation", selanjutnya program akan mencari kecocokan dengan argumen tersebut
% pertama program akan memulai dari Killer(Killer) maka prolog mencari argumen yang cocok dengan Killer karena yang di temukan bahwa yg terbunuh adalah susan
% lalu prolog akan mencoba ke subgoal berikutnya yaitu dicurigai(pembunuh) selanjutnya memanggil dicurigai(x) karena
% sub berikutnya  Killed_ dengan(susan,Club) lalu prolog akan memanggil Killed_ dengan(susan,club)
% setelah itu prolog menemukan kalau Susan terbunuh oleh Club(Pentungan)
% prolog akan ke sub berikutnya yaitu operates_identically, setelah itu prolog mengecek semua yang bernilai ada Club nya.
% Disitu ada 3 point yang bernilai Club. Yaitu Wooden_Leg, Bar, football_boot.
% Lalu lanjut ke sub berikutnya yaitu owns_probably(kemungkinan_punya), karena yang punya Wooden_Leg cuma si Bert
% jadi prolog sudah menemukan bukti-bukti yang dicurigai tadi.
% lanjut ke sub berikutnya, yaitu smeared_in(Killer,Goo).
% prolog akan mengecek dan mendapatkan kalau yang berlumuran darah yaitu Bert dan Susan.
% karena yang berlumuran darah Bert dan Susan, dan Susan yang terbunuh, Jadi Bert lah yang menjadi Tersangkanya.

% Hanya segitu yang saya tau kak :) :) 