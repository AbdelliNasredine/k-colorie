program nAS;

// Prog made by <'Nasro'> 
// If you have any questions , Comment them in the post
// and i will try to answer them

uses
	Sysutils,crt;
 
const
	// file_name = nom de fichier de fichier physique (dans le disque dure , etc )
	File_name = 'M_de_adj.txt';
  // 32 est le nombre maximum de sommet reserver dans la matrice , ajouter plus si tu veux ;)
  total_sommet = 32;

type  
  matrice = array[1..total_sommet , 1..total_sommet] of Integer;
  tab = array[1..total_sommet] of Integer;

var
  // max_s = le nombre de sommet utiliser 
  max_s : Integer;

Function char_to_int (v1,v2 : char):Integer;
var r : Integer;
begin
  // cette fonction traduit un string de 2 char var un entier 
  // 'ord' return le code ascii de carectaire passer comme parametre 
  if v1 = '0' then
    char_to_int := ord(v2) - 48
  else
    begin
      r := ord(v1) - 48;
      r := r * 10;
      char_to_int := ( ord(v2) - 48 ) + r;
    end;
end;

function kayen_des_sommet_bla_color(m2 : matrice): Boolean;
var
  c2 : Integer;
  test : Boolean;
begin
  // cette fonction test si 'kayen_des_sommet_bla_color' :)
  test :=false ;
  c2 := 1;
  kayen_des_sommet_bla_color := false;
  while (c2 <= max_s) and (not test) do
  begin
    if (m2[c2][max_s + 2] = 0) then
    begin
      kayen_des_sommet_bla_color := true;
      test := true;
    end;
  c2 := c2 + 1;
  end;
end;


function sommet_adj_meme_color(s , color :Integer ; m1 : matrice): Boolean;
var 
    c1  : Integer;
    stop : Boolean;

begin
  // cette fonction test si un sommet 's' n'a pas des sommet-adjacent avec
  // le meme color que 's'
  sommet_adj_meme_color :=false;
  stop :=false;
  c1 := 1;
  while (c1 <= max_s) and (not stop) do
  begin
    if s <> c1 then
      if (m1[s][c1] = 1) and (m1[c1][max_s + 2] = color) then
      begin
          sommet_adj_meme_color := true;
          stop := true;
      end;
      c1 := c1 + 1;
  end;  
end;

Procedure cree_tab_adj(var x : tab ; m1 : matrice );
var 
  c1 , c2 , s : Integer;
begin
  // cette Procedure remplie + trie la table d'adj :
  // remplicage de 'x' avec les degree de chaque sommet
  for c1 := 1 to max_s do
    x[c1] := c1;
  // le triage de x selon le degree de sommet
  for c1 := 1 to max_s do
    for c2 := 1 to max_s do
      if (m1[ x[c2] ][max_s + 1 ] < m1[ x[c1] ][max_s + 1 ]) then
      begin
        s := x[c1];
        x[c1] := x[c2];
        x[c2] := s;    
      end; 
  if(c1 < total_sommet) then
    // valeur d'arrét = -1998 ;)
    x[c1 + 1] := -1998;
end;

var
	// F = fichier logic utilisable par le programe 
  F : TextFile;
  // s = le line de fichier .txt
 	s : string[total_sommet];
 	// les variable de program :
  	m : matrice; 
  	i , j , k_color : Integer;
  	t : tab;
 
begin
	  clrscr;
	  writeln('La lecture de fichier ''.txt'' : ', File_name);
	  writeln('**************Apuier sur [Enter]**************');
 	  Assign (F,File_name);
  	// Ovrire le fichier pour la lecture seulment !
    reset(f);
    j:= 0;
    readln(f , s);
    // max_s = le nombre max de sommet existe dans le fichier .txt
    max_s := char_to_int(s[1],s[2]);
  	// la lecture jsuqu'a la fin de fichier (eof)
  	while not eof(f) Do
  	begin
    	readln(f, s);
      	j:= j + 1;
      	m[j][max_s + 1] := 0;
    	for i := 1 to max_s do
        if s[i] = '1' then
          begin
            m[j][i] := 1;
            m[j][max_s + 1] := m[j][max_s + 1] + 1; // calcule de degree
          end  
        else
          m[j][i] := 0;
    end;
    // fermeture de fichier .txt
  	close (f);
  	readln;
  	clrscr;
    // creation de table de degree :
    cree_tab_adj(t,m);
    // initialisation de 'k_color'
    k_color := 0;
    // le traitement :
    while ( kayen_des_sommet_bla_color(m) ) do
    begin
      k_color := k_color + 1;
      j := 1; 
      while t[j] <> -1998 do
      begin
        if (m[ t[j] ][max_s + 2] = 0) and ( not sommet_adj_meme_color( t[j] , k_color , m) )then
          m[ t[j] ][max_s + 2] := k_color;
        j:= j + 1;
      end;
    end;
    // Affichage :
    writeln('******************************************************************');
    writeln('le minimum nombre de color pour colorer le graphe est =',k_color);
    writeln('******************************************************************');
    writeln('Les Class : " les nombre represonte les sommet, exp: s1 = 1 "');
    for i := 1 to k_color do
    begin
    write('C',i,'= { ');
      for j := 1 to max_s do
        if m[j][max_s + 2] = i then
          write(' ',j,' ');
    write('}');      
    writeln('');
    end;
    // supprimer l '{' et '}' pour afficher la matrice avec la table d'adjac :
    {
      for i:=1 to max_s  do
        begin
          for j := 1 to max_s + 2 do
            write(m[i][j]);
          writeln('');
        end;  
      for i := 1 to Length(t) do
        write(' ',t[i],' ');
    }
    writeln('******************************************************************');
    writeln('Apuier sur [Enter] pour quiter');
    readln();
end.