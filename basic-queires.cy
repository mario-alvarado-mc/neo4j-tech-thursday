// Clear all data
MATCH (n)
DETACH DELETE n;

// Create employees and equipments
CREATE (e1:Employee
{
  id: randomUUID(),
  name: 'Mario',
  lasName: 'Alvarado',
  email: 'mario.alvarado@mangochango.com'
}
)
CREATE (e2:Employee
{
  id: randomUUID(),
  name: 'Marvin',
  lasName: 'Alvarado',
  email: 'malvarado@mangochango.com'
}
)
CREATE (laptop1:Equipment:Laptop
{
  id: randomUUID(),
  serialNumber: '1234567890',
  cpu: 'Intel Core i7',
  ram: '16GB'
}
)
CREATE (mouse1:Equipment:Mouse
{
  id: randomUUID(),
  serialNumber: '0987654321',
  isWireless: true
}
)
CREATE (laptop1)-[:ASSIGNED_TO]->(e1)
CREATE (mouse1)-[:ASSIGNED_TO]->(e2);

// Query employees and equipments (Bad query)
MATCH (e:Employee)-[:ASSIGNED_TO]->(eq:Equipment)
RETURN e.name, eq.serialNumber;

// Query employees and equipments (Good query)
MATCH (e:Employee)<-[:ASSIGNED_TO]-(eq:Equipment)
RETURN e.name, eq.serialNumber;

// Query employees and equipments Nodes
MATCH (e:Employee)<-[:ASSIGNED_TO]-(eq:Equipment)
RETURN e, eq;

// Set a new relationship
MATCH (e:Employee { name: 'Mario' }), (eq:Equipment {serialNumber: '0987654321'})
CREATE (eq)-[:PREVIOUSLY_ASSIGNED_TO]->(e);

// Add data to relationship
MATCH (e:Employee { name: 'Mario' })<-[r:PREVIOUSLY_ASSIGNED_TO]-(eq:Equipment {serialNumber: '0987654321'})
 SET r.assignedDate = datetime('2024-01-01T00:00:00-06:00')
 SET r.returnedDate = datetime('2024-06-01T00:00:00-06:00');

// Query history of employees and equipments
MATCH (e:Employee)<-[:PREVIOUSLY_ASSIGNED_TO]-(eq:Equipment)
RETURN e, eq;
