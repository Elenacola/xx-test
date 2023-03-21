
CREATE DATABASE GestGift;

USE GestGift;

CREATE TABLE Clienti
(
CodFidelity varchar(20) not null primary key,
Nome varchar(50) not null,
Cognome varchar(60) not null,
Indirizzo varchar(80),
Comune varchar(50),
Cap nchar(6),
Prov nchar(2),
Telefono1 varchar(30),
Telefono2 varchar(30),
Mail1 varchar(30),
Mail2 varchar(30)
);

CREATE TABLE Cards
(
CodFidelity varchar(20) not null primary key,
foreign key (CodFidelity) references Clienti(CodFidelity),
Bollini int,
UltimaSpesa date 
);

CREATE TABLE Premi
(
Codice varchar(20) not null primary key,
Descrizione varchar(50) not null,
Bollini int,
Contributo double 
);

CREATE TABLE Prenotazioni
(
id int auto_increment not null primary key,
CodPremio varchar(20),
foreign key (CodPremio) references Premi(Codice),
CodFidelity varchar(20),
foreign key (CodFidelity) references Clienti(CodFidelity),
DataPrenotaz datetime,
Qta int,
DataRitiro datetime);



