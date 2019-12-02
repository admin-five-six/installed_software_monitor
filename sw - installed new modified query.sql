Create Temporary Table Tcomp (INDEX (Computerid)) 
SELECT SubGroupwchildren.computerid,SubGroupwchildren.GroupID,Mastergroups.Priority  
FROM SubGroupwchildren 
JOIN Mastergroups USING(groupid) 
WHERE  
	FIND_IN_SET(SubGroupwchildren.groupid,'856,2,4,3,855,1574') 
	AND SubGroupwchildren.ComputerID 
	NOT IN (Select ComputerID from AgentIgnore Where AgentID=167);
		Select DISTINCT 'C',computers.computerid,computers.Name as ComputerName,Convert(CONCAT(clients.name,' ',locations.name) Using utf8) As Location, software.`DateInstalled` as TestValue,software.Name 
		FROM ((software LEFT JOIN Computers ON Computers.ComputerID=software.ComputerID) 
		LEFT JOIN Locations ON Locations.LocationID=Computers.Locationid) 
		LEFT JOIN Clients ON Clients.ClientID=Computers.clientid 
		JOIN AgentComputerData on Computers.ComputerID=AgentComputerData.ComputerID 
		WHERE software.`DateInstalled` > date_add(NOW(),interval -1 day) AND  
			(Computers.AssetDate<DATE_ADD(NOW(),interval -1 day) and 
			software.name not in (select hotfixdata.title from hotfixdata) and 
			software.name not like '%skype%' and 
			software.name not like '%flash player%' and 
			software.name not like '%chrome%'  and  
			software.name not like '%adobe reader%' and 
			software.name not like '%apple application%' and 
			software.name not like '%cutepdf%' and 
			software.name not like '%quicktime%' and 
			software.name not like '%itunes%' and 
			software.name not like '%mozilla%' and 
			software.name not like '%shockwave%' and 
			software.name not like '%oracle java%')  AND 
			Computers.ComputerID IN (Select Distinct ComputerID From Tcomp); 
Drop TEMPORARY Table if exists Tcomp;