--1--
-a-
create role Profesor;
grant all privileges on grupo
to Profesor 

-b-
create role Estudiante;
grant select on estudiante, curso,depar
to Estudiante

-c-
create role Coordinador;
grant all privileges on inscripcion, horario
to Coordinador;

grant select on facultad, curso, departamento
to Coordinador


--2--
-a-
alter table estudiante
add constraint gen_especifico check (genero in ('F','M','O'))

-b-
alter table curso
add constraint cred_especifico check (creditos in (2,3,4,5))

--3--
-a-
create function insxanio(anio_ins int, periodo_ins int)
	returns table(
		nombre varchar,
		apellido varchar,
		curso varchar,
		grupo varchar,
		calificacion smallint)
	language plpgsql as
	$$
	begin
	return query
		select e.nombre, e.apellido, c.nombre, g.nombre, i.calificacion
		from ((estudiante e join inscripcion i on (e.codigo=i.codigo_estudiante))
						   join grupo g on (g.id=i.id_grupo))
						   join curso c on (c.id=g.id_curso)
		where g.anio = anio_ins and g.periodo=periodo_ins;
	end;
	$$

select insxanio (2020,2)

select * from insxanio (2020,2)
	
	
-b-

create function edad_est (est_id int) returns int
language plpgsql as
$$
declare
	efecha date;
	anio int;
	mes int;
	dia int;
	eanio int;
	emes int;
	edia int;
	edad int;
begin 
	anion = extract(year from current_date)
	mes = extract(month from current_date)
	dia = extract(day from current_date)
	
	select e.fecha_nacimiento into efecha
	from estudiante e
	where e.codigo=est_id;
	
	eanio = extract(year from efecha) 
	emes = extract(month from efecha)
	edia = extract(year from efecha)
	
	return edad;
end;
$$

create or replace function edad_est (est_id int) returns int
	language plpgsql as
	$$
	declare edad int;
	begin 
	
		select currect_date - e.fecha_nacimiento
		from estudiante e
		where e.codigo=est_id;
	
		return edad/365;
	end;
	$$

create or replace function edad_est (est_id int) returns int
	language plpgsql as
	$$
	declare edad int; fecha date;
	begin 
	
		select e.fecha_nacimiento into fecha
		from estudiante e
		where e.codigo=est_id;
		
		edad = extract(year from current_date) - extract(year from fecha);
		if extract(month from current_date) < extract(month from fecha) then
			edad = edad -1;
		elseif extract(day from current_date) = extract(day from fecha) then
			if extract(day from current_date) < extract(day from fecha) then
				edad = edad -1;
			end if;
		end if;
		
		return edad;
	end;
	$$
	
select edad_est (10)
	
-c-
create function curso_count(cod int)
	returns integer
	language plpgsql as
	$$
	declare c_count integer;
	begin
		select count(c.id) into c_count
		from ((estudiante e join inscripcion i on (e.codigo=i.codigo_estudiante))
						   join grupo g on (g.id=i.id_grupo))
						   join curso c on (c.id=g.id_curso)
		where e.codigo = cod;
		return c_count;
	end;
	$$

select curso_count(2)

-d,e-
alter table estudiante
add column promedio real

create or replace function promedio() returns real
language plpgsql
as
$$
declare
	prom real;
	suma_calif real;
	suma_creditos real;
	prom_total real;
	num_est real;
	cod int;
begin
	prom_total = 0;
	num_est = 0;
	for cod in (select codigo from estudiante)
	loop
	select sum(ins.calificacion*cur.creditos) into suma_calif
	from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante)
						join grupo gru on (ins.id_grupo = gru.id)
						join curso cur on (gru.id_curso = cur.id)
	where est.codigo = cod;
	
	select sum(cur.creditos) into suma_creditos
	from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante)
						join grupo gru on (ins.id_grupo = gru.id)
						join curso cur on (gru.id_curso = cur.id)
	where est.codigo = cod;
	if suma_creditos <> 0 then
		prom = suma_calif / suma_creditos;
		prom_total = prom_total + prom;
		num_est = num_est + 1;
		
	update estudiante
	set promedio = prom
	where codigo = cod;
	end if;
	end loop;
	prom_total = prom_total / num_est;
	return prom_total;
end;
$$

--4--
-a-
alter table estudiante
add column mayor bool

alter table estudiante
add column creditos int

-b-
create or replace function cred() returns trigger
language plpgsql
as
$$
declare
	cred_total int;
	cod int;
begin
	for cod in (select codigo from estudiante)
	loop
		select sum(c.creditos) into cred_total
		from estudiante e join inscripcion i on (i.codigo_estudiante = e.codigo)
						  join grupo g on (g.id=i.id_grupo)
					 	  join curso c on (c.id=g.id_curso)	
		where e.codigo = cod;

		update estudiante set creditos = cred_total
		where codigo = cod;
	
	end loop;
	return new;
end;
$$

create trigger trigger_cred
after update on curso
for each row
	execute procedure cred()

update curso set creditos = 2 where id =9


-c-
create or replace function f_mayor_edad() returns trigger
language plpgsql
as
$$
declare
	fecha18 date;
	anio18 int;
	mes int;
	dia int;
begin
	if new.fecha_nacimiento <> old.fecha_nacimiento then
		anio18 = extract(year from current_date);
		mes = extract(month from current_date);
		dia = extract(day from current_date);
		fecha18 = make_date(anio18,mes,dia);
		if new.fecha_nacimiento < fecha18 then
			update estudiante set mayor = 'true'
			where codigo = new.codigo;
		else
			update estudiante set mayor = 'false'
			where codigo = new.codigo;
		end if;
	end if;
	return new;
end;
$$

create trigger trigger_mayor_edad
after update on estudiante
for each row
	execute procedure f_mayor_edad()




-d-
create or replace function prom_update() returns trigger
language plpgsql
as
$$
declare
	prom_actual real;
	prom real;
	sum_creditos real;
	prom_total real;
	creditos real;
begin
	if new.calificacion <> old.calificacion then
		select promedio into prom_actual
		from estudiante
		where codigo = new.codigo_estudiante;
	
		select sum(cur.creditos) into sum_creditos
		from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante)
							join grupo gru on (ins.id_grupo = gru.id)
							join curso cur on (gru.id_curso = cur.id)
		where est.codigo = new.codigo_estudiante;
		
		select cur.creditos into creditos
		from inscripcion ins join grupo gru on (ins.id_grupo = gru.id)
							 join curso cur on (gru.id_curso = cur.id)
		where ins.id = new.id;		

		prom = (prom_actual*sum_creditos) - (creditos*old.calificacion) + (new.calificacion*creditos);
		prom_total = prom/sum_creditos;

		update estudiante set promedio = prom_total
		where codigo = new.codigo_estudiante;
		
	end if;
	return new;
end;
$$

create trigger trigger_promedio_update
after update on inscripcion
for each row
	execute procedure prom_update()
	
drop trigger trigger_pasar
on estudiante cascade