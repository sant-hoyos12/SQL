-- Taller 5 --

--1a,b,c,d--
create table prerequisitos(
	id smallint,
	id_curso smallint,
	id_prerequisitos smallint,
	primary key (id),
	foreign key (id_prerequisitos) references curso(id),
	foreign key (id_curso) references curso(id))
	
insert into prerequisitos 
values (1,2,1),(2,2,4),(3,4,12),(4,4,3),(5,1,10),(6,12,11)

--2a--

with recursive prerre_ing as (
	(select p.id, c.nombre
	from prerequisitos p
	where id_curso=2)
	union
	(select pre.id
	from prerequisitos pre
	join curso c on (pre.id_curso=c.id))
)select * from prerre_ing;
	
with recursive prerre_ing_nom as (
	(select id
	 from prerequisitos p join curso c1 on (p.id_curso = c1.id)
	 					  join curso c2 on (p.id_prerequisitos=c.id)
	 where c.nombre='Ingeniería de Datos')
	union
	(select id
	from prerequisitos pre
	join prerre_ing_nom pr on (pre.id=pr.id_prerequisitos))
)select * from prerre

