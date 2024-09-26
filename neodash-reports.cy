// Computadora asignada a empleado
MATCH (l:Laptop)-[:ASSIGNED_TO]->(e:Employee)
RETURN l.brand, l.serialNumber, e.name;

// Marcas de computadoras
MATCH (l:Laptop)
RETURN l.brand, COUNT(l.brand);

// Tipo de CPU mas usado
MATCH (l:Laptop)
RETURN l.cpu, count(l.cpu);

// Listado de personas por marca de computadora
MATCH (e:Employee)<-[:ASSIGNED_TO]-(l:Laptop)
WHERE l.brand = $neodash_laptop_brand
RETURN e.name, e.email, l.serialNumber;

// Listado de laptops de cierta marca que aún no han sido asignadas
MATCH (l:Laptop)
WHERE NOT EXISTS((:Employee)<-[:ASSIGNED_TO]-(l))
 AND l.brand = $neodash_laptop_brand
RETURN l.serialNumber, l.brand

// Listado de equipo por persona
MATCH (e:Employee)<-[:ASSIGNED_TO]-(eq:Equipment)
WHERE e.name = $neodash_employee_name
RETURN eq.brand, eq.serialNumber labels(eq);

// Listado de personas por marca de mouse
MATCH (e:Employee)<-[:ASSIGNED_TO]-(m:Mouse)
WHERE m.brand = $neodash_mouse_brand
RETURN e.name, e.email;

// Listado de equipo actualmente asignado a un empleado
MATCH (e:Employee)<-[:ASSIGNED_TO]-(eq:Equipment)
WHERE e.name = $neodash_employee_name
RETURN eq.brand, eq.serialNumber, labels(eq);

// Historico de equipos por empleado
MATCH (e:Employee)<-[r:PREVIOUSLY_ASSIGNED_TO]-(eq:Equipment)
WHERE e.name = $neodash_employee_name
RETURN eq.brand, eq.serialNumber, r.assignedDate, r.unassignedDate, labels(eq);
