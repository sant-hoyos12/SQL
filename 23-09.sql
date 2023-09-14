-- Hurtos por cada 10000 habitantes --
select h.municipio,count(h.hurto_id) as hurtos, 
	   p.total_pop as poblacion, 
	   count(h.hurto_id)/(p.total_pop/10000) as total
from hurtos h join poblacion p on (h.codigo_dane=p.codigo_dane)
where p.total_pop>=10000
group by h.municipio, p.total_pop
order by total desc

-- Barrios con más de 100 hurtos (mejor con rollup) --
select municipio, barrio, count(hurto_id) as hurtos
from hurtos
group by cube (municipio, barrio)
having count(hurto_id)>100
order by hurtos desc

select municipio, barrio, count(hurto_id) as hurtos
from hurtos
group by rollup(municipio, barrio)
having count(hurto_id)>100
order by hurtos desc

--