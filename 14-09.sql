CREATE TABLE usuario(
id smallint NOT NULL,
nombre varchar(45) NOT NULL,
apellido varchar(45) NOT NULL,
venta int,
id_patrocinador smallint,
PRIMARY KEY (id),
FOREIGN KEY (id_patrocinador) REFERENCES usuario (id)
);



INSERT INTO usuario (id, nombre, apellido, venta, id_patrocinador) VALUES
(1, 'Michael', 'North',10000, NULL), (3, 'Megan','Berry',2000, 1),
(2, 'Sarah', 'Berry',5000, 1), (4, 'Zoe', 'Black',500, 3),
(5, 'Tim' ,'James',1000, 2)


with recursive utilidad AS (
	(select id, nombre, apellido, id_patrocinador, venta*0.05 as utility
	from usuario
	where id = 4)
	UNION
	(select us.id, us.nombre,us.apellido, us.id_patrocinador, (us.venta*0.05)+u.utility as utility
	from usuario us
	join utilidad u on us.id=u.id_patrocinador)
)

select * from utilidad;

--Agregacion avanzada--
-Ranking-
select codigo, nombre, apellido, promedio ,rank() over (
	order by promedio desc)
	posicion
from estudiante
where promedio is not null

-Window-
-agrupamiento de un atributo (group by tiene similitud)- 
select *, avg(estatura) over (
	partition by genero)
from estudiante

select nombre, apellido, genero, promedio, avg(promedio) over (
	partition by genero)
from estudiante
where promedio is not null
