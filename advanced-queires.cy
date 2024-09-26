// List all equipments assigned to an employee.
MATCH (e:Equipment)-[r:ASSIGNED_TO|PREVIOUSLY_ASSIGNED_TO]->(p:Employee)
RETURN p.name, e.serialNumber, r.assignedDate, r.returnedDate;

// Create index for Employee name
CREATE INDEX employe_name_index FOR (e:Employee) ON (e.name);

// Delete index for Employee name
DROP INDEX employe_name_index;
