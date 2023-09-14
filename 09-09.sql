--Disparadores/Triggers--
alter table estudiante
add column mayor bool

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

-<> diferente-

create or replace function f_mayor_edad_insert() returns trigger
language plpgsql
as
$$
declare
	fecha18 date;
	anio18 int;
	mes int;
	dia int;
begin
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
	return new;
end;
$$

create trigger trigger_mayor_insert
after insert on estudiante
for each row
	execute procedure f_mayor_edad_insert()
	
--ejercicios--
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

-1-
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

update inscripcion
set calificacion = 40
where codigo_estudiante=1 and id = 3



-2-
create or replace function prom_update_cred() returns trigger
language plpgsql
as
$$
declare
	prom_actual real;
	prom real;
	sum_creditos real;
	prom_total real;
	calificacion int;
	c int;
begin
	if new.creditos <> old.creditos then
		
		
		for c in (select e.codigo
				  from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante)
							join grupo gru on (ins.id_grupo = gru.id)
							join curso cur on (gru.id_curso = cur.id)
			      where id=new.id)
		loop
			select promedio into prom_actual
			from estudiante
			where codigo = c;

			select sum(cur.creditos) into sum_creditos
			from estudiante est join inscripcion ins on (est.codigo = ins.codigo_estudiante)
								join grupo gru on (ins.id_grupo = gru.id)
								join curso cur on (gru.id_curso = cur.id)
			where codigo = c;

			select i.calificacion into calificacion
			from inscripcion ins join grupo gru on (ins.id_grupo = gru.id)
								 join curso cur on (gru.id_curso = cur.id)
			where cur.id = new.id;

			prom = (prom_actual*sum_creditos) - (old.creditos*calificacion) + (calificacion*new.creditos);
			prom_total = prom/sum_creditos;

			update estudiante set promedio = prom_total
			where codigo = c;
		end loop;
		
	end if;
	return new;
end;
$$

create trigger trigger_promedio_update_cred
after update on curso
for each row
	execute procedure prom_update_cred()
	


