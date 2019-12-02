Create Temporary Table Tcomp (INDEX (Computerid)) 
SELECT SubGroupwchildren.computerid,SubGroupwchildren.GroupID,Mastergroups.Priority  
FROM SubGroupwchildren 
JOIN Mastergroups USING(groupid) 
WHERE  
	FIND_IN_SET(SubGroupwchildren.groupid,'856,2,4,3,855,1574') 
	AND SubGroupwchildren.ComputerID 
	NOT IN (Select ComputerID from AgentIgnore Where AgentID=167);
		Select DISTINCT 'C',computers.computerid,computers.Name as ComputerName,Convert(CONCAT(clients.name,' ',locations.name) Using utf8) As Location, h_apps.`When` as TestValue,h_apps.Name 
		FROM ((h_apps LEFT JOIN Computers ON Computers.ComputerID=h_apps.ComputerID) 
		LEFT JOIN Locations ON Locations.LocationID=Computers.Locationid) 
		LEFT JOIN Clients ON Clients.ClientID=Computers.clientid 
		JOIN AgentComputerData on Computers.ComputerID=AgentComputerData.ComputerID 
		WHERE h_apps.`When` > date_add(NOW(),interval -1 day) AND  
			(h_apps.Action=1 And 
			Computers.AssetDate<DATE_ADD(NOW(),interval -1 day) and 
			h_apps.name not in (select hotfixdata.title from hotfixdata) and 
			h_apps.name not like '%skype%' and 
			h_apps.name not like '%flash player%' and 
			h_apps.name not like '%chrome%'  and  
			h_apps.name not like '%adobe reader%' and 
			h_apps.name not like '%apple application%' and 
			h_apps.name not like '%cutepdf%' and 
			h_apps.name not like '%quicktime%' and 
			h_apps.name not like '%itunes%' and 
			h_apps.name not like '%mozilla%' and 
			h_apps.name not like '%shockwave%' and 
			h_apps.name not like '%oracle java%')  AND 
			Computers.ComputerID IN (Select Distinct ComputerID From Tcomp); 
Drop TEMPORARY Table if exists Tcomp;