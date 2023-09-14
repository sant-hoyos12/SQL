-1a-
--(07-09)--
create role Profesor;
grant all privileges on grupo
to Profesor 

-2a-
alter table estudiante
add constraint gen_esp check (genero in ('F','M','O'))

-3a-
DROP FUNCTION inscxnotas(integer,integer)

create or replace function inscxnotas (per int, an int)
returns table (nombre varchar,
			   apellido varchar,
			   grupo varchar,
			   calificacion smallint)
language plpgsql as
$$
begin
	return query
		select e.nombre, e.apellido, g.nombre, i.calificacion
		from estudiante e join inscripcion i on (e.codigo=i.codigo_estudiante)
						  join grupo g on (i.id_grupo=g.id)
		where g.anio=an and g.periodo=per;
end;
$$

select * from inscxnotas (2,2020)

-3c-
create or replace function num_cur (e_id int) returns int
language plpgsql as
$$
declare num_cur int;
begin
	select count(c.id) into num_cur
	from curso c join grupo g on (c.id=g.id_curso)
				 join inscripcion i on (g.id=i.id_grupo)
				 join estudiante e on (i.codigo_estudiante=e.codigo)
	where e.codigo=e_id;
	
	return num_cur;
end;
$$

select num_cur(1) 

-4a-
triggers (07-09)			  
