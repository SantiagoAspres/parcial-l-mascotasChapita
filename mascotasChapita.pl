% Se tienen los siguientes functores:
% perro(tamaño)
% gato(sexo, cantidad de personas que lo acariciaron)
% tortuga(carácter)

mascota(pepa, perro(mediano)).
mascota(frida, perro(grande)).
mascota(piru, gato(macho,15)).
mascota(kali, gato(hembra,3)).
mascota(olivia, gato(hembra,16)).
mascota(mambo, gato(macho,2)).
mascota(abril, gato(hembra,11)).
mascota(buenaventura, tortuga(agresiva)).
mascota(severino, tortuga(agresiva)).
mascota(simon, tortuga(tranquila)).
mascota(quinchin, gato(macho,0)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Punto 1
esDuenio(martin,pepa, 2014,adopto).
esDuenio(martin,olivia, 2014,adopto).
esDuenio(martin,frida, 2015,adopto).
esDuenio(martin,kali, 2016,adopto).
esDuenio(constanza,abril, 2006,regalo).
esDuenio(constanza,mambo, 2015,adopto).
esDuenio(hector,abril,2015,adopto).
esDuenio(hector,mambo,2015,adopto).
esDuenio(hector,buenaventura,1971,adopto).
esDuenio(hector,severino,2007,adopto).
esDuenio(hector,simon,2016,adopto).
esDuenio(martin,piru,2010,compro).
esDuenio(hector,abril,2006,compro).
esDuenio(silvio,quinchin,1990, regalo).

% Punto 2
comprometidos(P1,P2):-
   esDuenio(P1,Mascota,Anio,adopto),
   esDuenio(P2,Mascota,Anio,adopto).

% Punto 3
locoDeLosGatos(Persona):-
   tieneMasDe1Mascota(Persona),
   forall(esDuenio(Persona,Mascota,_,_),esGato(Mascota)).

tieneMasDe1Mascota(Persona):-
   esDuenio(Persona,Mascota1,_,_),
   esDuenio(Persona,Mascota2,_,_),
   Mascota1 \= Mascota2.

esGato(Mascota):-
   mascota(Mascota, gato(_,_)).

% Punto 4
puedeDormir(Persona):-
   persona(Persona),
   not((esDuenio(Persona,Mascota,_,_),estaChapita(Mascota))).

persona(Persona):-
   esDuenio(Persona,_,_,_).

estaChapita(Mascota):-
   mascota(Mascota,Especie),
   especieChapita(Especie).
   
   especieChapita(perro(chico)).
   especieChapita(tortuga(_)).
   especieChapita(gato(macho,VecesAcariciado)):-
   VecesAcariciado < 10.

% Punto 5

% a)
crisisNerviosa(Persona,Anio):-
   esDuenio(Persona,Mascota,OtroAnio,_),
   estaChapita(Mascota),
   anioPasado(Anio,AnioPasado),
   esDuenio(Persona,Mascota2,AnioPasado,_),
   estaChapita(Mascota2),
   OtroAnio < AnioPasado.

anioPasado(Anio,AnioP):-
   AnioP is Anio - 1.
% b) No es inversible por el segundo argumento. Anio debe llegar ligada al is para que el is pueda resolver la cuenta.

% Punto 6
mascotaAlfa(Persona,Alfa):-
   esDuenio(Persona,Alfa,_,_),
   forall((esDuenio(Persona,Otra,_,_), Otra \= Alfa),domina(Alfa,Otra)).
  
domina(Mascota,Mascota2):-
   esGato(Mascota),
   mascota(Mascota2,perro(_)).
domina(Mascota,Mascota2):-
   mascota(Mascota,perro(grande)),
   mascota(Mascota2,perro(chico)).
domina(Mascota,_):-
   mascota(Mascota,tortuga(agresiva)).
domina(Mascota,Mascota2):-
   esGato(Mascota),
   esGato(Mascota2),
   estaChapita(Mascota).

% Punto 7
materialista(Persona):-
   persona(Persona),
   noTieneMascotas(Persona).
materialista(Persona):-
   persona(Persona),
   cantidadDeMascotas(Persona,compro,CantCompradas),
   cantidadDeMascotas(Persona,adopto,CantAdoptadas),
   CantCompradas > CantAdoptadas.

noTieneMascotas(Persona):-
   not(esDuenio(Persona,_,_,_)).

cantidadDeMascotas(Persona,Accion,Cantidad):-
   findall(Mascota,esDuenio(Persona,Mascota,_,Accion),ListaDeMascotas),
   length(ListaDeMascotas,Cantidad).