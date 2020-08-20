<!-- This is the confidential, unpublished property of AT&T.  Receipt or possession of it does not convey any rights to 
divulge, reproduce, use, or allow others to use it without the specific written authorization of AT&T, and use must conform
 strictly to the license agreement between user and AT&T. Copyright 2017 AT&T. All rights reserved  -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=11" />
<title>AT&amp;T - Offshore Online Tool</title>
<link href="css/custom.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet" >
<link href="css/tools.css" rel="stylesheet">
<script src="js/jquery-2.2.3.min.js"></script>
<script src="js/basic.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/angularApp/angular.min.js"></script>
<script type="text/javascript"
	src="js/angularApp/angular-sanitize.min.js"></script>
<script type="text/javascript"
	src="js/angularApp/moment-with-locales.js">
	
</script>
<script type="text/javascript"
	src="js/angularApp/angular-moment-picker.min.js">
	
</script>
<script type="text/javascript" src="js/angularApp/pmoAppModule.js"></script>
<script type="text/javascript"
	src="js/pmoapp.js"></script>
<script type="text/javascript"
	src="js/angularApp/controller/viewNotescontroller.js"></script>
<script type="text/javascript">
//To display/Hide Component Level notes 
function fnShowMode(flag)
{
	if(flag == 1){
		
	//var i;
		
		//If mode selected is Expand
		document.getElementById('modeType').innerHTML = "<a  onClick='fnShowMode(0);' style='cursor: pointer;'>Collapse Mode</a>";
		document.getElementById('tblComponetLvlNote').style.display = 'inline';
		document.getElementById('componentsRow').style.display = 'inline';
		//Release0616:Modified for design issue:By IMran
		//To Show Component Level Notes corresponding to Selected Group
		/*fnShowFD();
		fnShowSec();
		fnShowExp();
		fnShowConn();*/
		//fnSubmitAll();
		//Release0616:End Change
		
	}
	else {
		document.getElementById('modeType').innerHTML = "<a   onClick='fnShowMode(1);' style='cursor: pointer;'>Expand Mode</a>";
		document.getElementById('tblComponetLvlNote').style.display = 'none';
		document.getElementById('componentsRow').style.display = 'none';
	}
	//alert('fdghdfh');
}
</script>

<style>

#allNotes
{
	background-color:#6699FF; 
	width:82px;
	height:44px; 
	text-align:center; 
	float:left; 
	padding:5px;
	font-weight:bold; 
	font-size:11px;
	FONT-FAMILY: Tahoma, Verdana, Arial, Helvetica, sans-serif;
}

.errortext {
	 FONT-SIZE: 11px; 
	 MARGIN-LEFT: 3px;
	 COLOR: #ff1313; 
	 LINE-HEIGHT: 12px; 
	 FONT-FAMILY: Tahoma, Verdana, Arial, Helvetica, sans-serif;
}
</style>
</head>
<body ng-app="pmoApp" ng-controller="viewAllNotes" ng-init="frmPage='${frmPage}';getData();getData2(); isSpocEdit='${isSpocEdit}'; isClient='${isClient}'" style="margin-bottom:50px;"> 
	<!---Release0616:End Change--->

	<!-- <cfif isDefined('hdnPageAction')>
		<cfif hdnPageAction eq 'save'>
			<cfset fnSave()>
		</cfif>
		<cfif hdnPageAction eq 'delete'>
			<cfset fnDelete()>
		</cfif>
	</cfif> -->
	
	<form name="ConsolNotes" method="get" action="{{'Notes.do?workgrp='+wrkGrp+'&frmpage=' +frmPage}}">
	<input type="hidden" id="hdnIsClient" name="hdnIsClient" value="${isClient}">
	//<input type="hidden" id="hdnPageAction" name="hdnPageAction" value="-1">
	<!--- List of deleted Work Grp Notes ID --->
	<input type="hidden" id="hdnDelWrkNote" name="hdnDelWrkNote" value="">
	<input type="hidden" id="hdnDelCompNoteType" name="hdnDelCompNoteType" value="">
	<input type="hidden" id="hdnDelCompNoteAddInfo" name="hdnDelCompNoteAddInfo" value="">
	<!--- List of deleted Component level Notes ID --->
	<input type="hidden" id="hdnDelCompNoteId" name="hdnDelCompNoteId" value="">  
    <!--- List of deleted Request Notes ID --->
    <input type="hidden" id="hdnDelReqNote" name="hdnDelReqNote" value="">
    <!---Release0616:Added hidden variables for checkboxes:by Imran--->
    <input type="hidden" id="hdnload" name="hdnload" >
    <input type="hidden" id="hdnFrontdoor" name="hdnFrontdoor" value="${hdnFrontdoor}"/>
    <input type="hidden" id="hdnSecurity" name="hdnSecurity" value="${hdnSecurity}" />
    <input type="hidden" id="hdnExport" name="hdnExport" value="${hdnExport}" />
    <input type="hidden" id="hdnConnectivity" name="hdnConnectivity" value="${hdnConnectivity}" />
    <input type="hidden" id="hdnRAClient" name="hdnRAClient" value="${hdnRAClient}"/>
    <input type="hidden" id="hdnClient" name="hdnClient"  value="${hdnClient}"/>
    <input type="hidden" id="hdnUserId" value="${SBCUID}">
    <input type="hidden" id="hdnWrkGrpId" value="${wrkGrpId}">
    <input type="hidden" id="hdnRoleId" value="${roleIds}">
    <!---Release0616:End Change--->
    
    <!---Release1115: Check for Supplier SPOC access: By Shreya(11/25/15) --->
 <!-- <cfif isDefined('client.WrkGrpSPOC') and client.WrkGrpSPOC neq ''>
 <cfset SPOCEdit = 0>
 <cfif ListFind(client.wrkGrpAll,client.WrkGrpSPOC) >
 <cfset SPOCEdit = 1>
 </cfif>
 </cfif> -->
    
	<div style="width:900px">
		<div class="pageHeader" style="margin-left:408px;">View Notes</div>
		<!--  <cfoutput>-->
		<fieldset style="width:600px; border:1px groove threedface; padding: 3px 5px 6px 5px; margin: 0px 148px; " >
			<div id="allNotes">
			<b>Notes <br>Group</b>
			</div>
			<div style="float:left; width:500px; margin-left:5px;">
			<table width="600px" class="smalltext" style="table-layout:fixed;">
				<tr ng-if="isClient==0">
				<!--- Notes will be shown on the basis of selected corresponding group  --->
		
					
					
					
					<!--- Client (ICRM,PCRM,Secondary Client, Primary Client) can only see client group notes --->
					<!--  <cfif ListFind(client.serializedtask, TASKID.VIEW_ALL_CONSOLIDATED_NOTES) neq 0> -->
					
							
							<td rowspan="1" colspan="1"><input type="checkbox" id="chkFrontdoor" name="chkFrontdoor" ng-click="fnSubmit('Frontdoor');" ${FrontDoor}/>
									<!-- <cfif  (ListFind(client.roleid,ROLE_FRONT_DOOR) OR ListFind(client.roleid,ROLE_SECURITY_MANAGER)) and (isDefined('hdnFrontdoor') and #hdnFrontdoor# eq 1)> checked<cfelseif (ListFind(client.roleid,ROLE_FRONT_DOOR) OR ListFind(client.roleid,ROLE_SECURITY_MANAGER)) and(not isDefined('hdnFrontdoor'))>checked<cfelseif (isDefined('hdnFrontdoor') and #hdnFrontdoor# eq 1)>checked</cfif> -->
									<b>Frontdoor</b>
                                   
							</td>
							<td rowspan="1" colspan="1"><input type="checkbox" id="chkSecurity" name="chkSecurity" ng-click="fnSubmit('Security');" ${Security}/> 
									<!-- <cfif  (ListFind(client.roleid,ROLE_FRONT_DOOR) OR ListFind(client.roleid,ROLE_SECURITY_MANAGER))and (isDefined('hdnSecurity') and #hdnSecurity# eq 1)> checked<cfelseif (ListFind(client.roleid,ROLE_FRONT_DOOR) OR ListFind(client.roleid,ROLE_SECURITY_MANAGER))and (not isDefined('hdnSecurity'))>checked<cfelseif (isDefined('hdnSecurity') and #hdnSecurity# eq 1)>checked</cfif>-->
									<b>Security</b>
							</td>                        
							<td rowspan="1" colspan="1"><input type="checkbox" id="chkExport" name="chkExport" ng-click="fnSubmit('Export');" ${Export}/>  
									<!--  <cfif  ListFind(client.roleid,ROLE_EXPORT_MANAGER) and (isDefined('hdnExport') and #hdnExport# eq 1)>checked<cfelseif ListFind(client.roleid,ROLE_EXPORT_MANAGER) and (not isDefined('hdnExport'))>checked<cfelseif (isDefined('hdnExport') and #hdnExport# eq 1)>checked</cfif>-->
									<b>Export</b>
							</td>
						
							<td rowspan="1" colspan="2"><input type="checkbox" id="chkConn" name="chkConn"  ng-click="fnSubmit('Connectivity');" ${connectivity}/> 
									<!-- <cfif  (ListFind(client.roleid,ROLE_IND_CONN_MANAGER) OR ListFind(client.roleid,ROLE_CON_PMO_MANAGER)) and (isDefined('hdnConnectivity') and #hdnConnectivity# eq 1)>checked<cfelseif (ListFind(client.roleid,ROLE_IND_CONN_MANAGER) OR ListFind(client.roleid,ROLE_CON_PMO_MANAGER)) and (not isDefined('hdnConnectivity'))>checked<cfelseif (isDefined('hdnConnectivity') and #hdnConnectivity# eq 1)>checked</cfif>-->
									<b>Connectivity</b>
							</td>
                        </tr>
                  
					<tr>
					
					<!-- </cfif> -->
                    <td rowspan="1" colspan="2"><input type="checkbox" id="chkRQClient" name="chkRQClient"  ng-click="fnSubmit('RAClient');"/><!--<cfif isDefined('hdnRAClient') and #hdnRAClient# eq 1>checked</cfif>--> 
                            <!---<cfif ListFind(client.roleid,ROLE_PRIMARY_CLIENT) OR ListFind(client.roleid,ROLE_IND_CONN_REQUIREMENT_MANAGER) OR 
                            ListFind(client.roleid,ROLE_SECONDRY_CLIENT)>checked</cfif>---><b>Request Assistance-Client View</b>
                    </td>
                    <!---Release1115:Modified for including Supplier SPOC role:By Imran--->                  
					<td rowspan="1" colspan="1"><input type="checkbox" id="chkClient" name="chkClient"  ng-click="fnSubmit('Client');" ${Client}/>
							<!-- <cfif (ListFind(client.roleid,ROLE_PRIMARY_CLIENT) OR ListFind(client.roleid,ROLE_IND_CONN_REQUIREMENT_MANAGER) OR 
							ListFind(client.roleid,ROLE_SECONDRY_CLIENT) OR ListFind(client.roleid,ROLE_SUPPLIER_SPOC)) and (isDefined('hdnClient') and #hdnClient# eq 1)>checked<cfelseif (ListFind(client.roleid,ROLE_PRIMARY_CLIENT) OR ListFind(client.roleid,ROLE_IND_CONN_REQUIREMENT_MANAGER) OR 
							ListFind(client.roleid,ROLE_SECONDRY_CLIENT) OR ListFind(client.roleid,ROLE_SUPPLIER_SPOC)) and (not isDefined('hdnClient'))>checked<!-- <cfelseif (isDefined('hdnClient') and #hdnClient# eq 1)> checked<!-- </cfif>> --><b>Client</b>
					</td>
                    <!---Release0616:End Change--->
					</tr>
			</table>
			</div>
		</fieldset>
		<!--- To get note details --->
        <!-- <cfset getDataForNotes()>-->  
        
		<br>
		<br>
		<!--<cfif ListFind(client.serializedtask, TASKID.VIEW_ALL_CONSOLIDATED_NOTES) neq 0>-->
			<div id="modeType" style="font-weight:bold; font-size:13px; color:#6699FF; margin-left:408px;"><a  onClick="fnShowMode(1);" style="cursor: pointer;">Expand Mode</a></div>
		<!-- </cfif>
		</cfoutput>-->
		<!--- Table for WorkGroup level Notes --->
		<div class="headtext" align="left" style="margin-left: 130px;">WorkGroup Level Notes:</div>
		<table id="notes" width="650px" class="dataTable smalltext" style= "table-layout:fixed; margin-left: 130px; margin-top:0px;">
			<colgroup>
				<col width="25"><!--- Serial Number--->                
				<col width="160"><!--- Category --->
                <!--- Release Sep'14 | To show request id column when Request Assistance checkbox is checked | By Dakshata Gaikar --->
                <!---Release0616:Commented by IMran--->
                <!---<col style="width=0;" id = "RequestIdColWidth">---><!--- RequestID --->
                <!-- <cfif isDefined('hdnRAClient') and #hdnRAClient# eq 1><col width="50"></cfif> -->
                <!---Release0616:End Change--->
				<col width="50" ng-if="collapsenoteclass.iRAClient==1">
				<col width="200"><!--- Notes --->
				<col width="70"><!--- Added On --->
				<col width="70"><!--- Added By --->
				<col width="45"><!--- Delete ---> 		
			</colgroup>
			<!-- <cfoutput> --> 
			<thead>
				<tr bgcolor="#6699FF" class="headtext" align="center" style="color:#FFFFFF" height="50px" nowrap>
					<th class="headtext" width="25">#</th>	
					<th class="headtext" width="160">
						Category
						<br>
						<img src="images/UpArrow.gif" ng-click="orderByField='category'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='category'; reversedSort = true" />
					</th>
                     <th class="headtext" id="raClientColumnhead"  ng-if="collapsenoteclass.iRAClient==1">
						Request Id
						<br>
						<img src="images/UpArrow.gif" ng-click="orderByField='requestId'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='requestId'; reversedSort = true"/>
					</th>
                    
                    <!---Release0616:End Change--->
					<th class="headtext" width="200">Notes</th>
					<th class="headtext" width="70">
						Added On
						<br>
						<img src="images/UpArrow.gif" ng-click="orderByField='addedOnSort'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='addedOnSort'; reversedSort = true"/>
					</th>
					<th class="headtext"  width="70">
						Added By
						<br>
						<img src="images/UpArrow.gif"  ng-click="orderByField='addedBy'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='addedBy'; reversedSort = true" />
                        
					</th>
					<th class="headtext" width="45" ng-hide="${not isOCELead}">Delete</th>
				</tr>
				
				<tr style="border-bottom:1px;">
					<td></td>
					
					<td>
						
						<select id="selCategory" name="selCategory" class="smalltext" style="width:160px" onChange="fnDisableReq();" >
							<option value="-1">Select</option>
							<option ng-repeat="note in data" value="{{note.catAcronym}}"  ng-selected="note.catAcronym==frmPage">{{note.category}}</option>
						</select>
					</td>
                    
                    
                   <td ng-if="collapsenoteclass.iRAClient==1"> 
						
					</td> 
                   
					<td>
						<textarea name="txtNewNote" id="txtNewNote" cols="37"  rows="3" class="smalltext" onKeyPress="fnCheckReq();"  onKeyUp="fnCheckTextAreaLength(this,2000)"></textarea>
					</td>
					<td></td>
					<td></td>
					<td ng-hide="${not isOCELead}"></td>
				</tr>
			</thead>
			<tbody>
				
                        <tr ng-repeat="cNote in collapsedNotesData | orderBy: orderByField : reversedSort " >
                        <!---Release0616:End Change--->
                        	<td align="center">{{$index+1}}</td>
							<td align="center">{{cNote.category==''?'Frontdoor-Workgroup':categoryFilter[cNote.category]}}</td>                            
                            <td align="center" id="raClientColumn" ng-if="collapsenoteclass.iRAClient==1">{{cNote.requestId==''?'-':cNote.requestId}}</td>
                            
                           
							<td style="word-wrap:break-word">{{cNote.note}}</td>
							<td align="center" >
								{{cNote.addedOn | date: 'MM/dd/yyyy'}}
								<!-- #DateFormat(ADDED_ON,"mm/dd/yyyy")# -->
							</td>
							<!-- <cfset addedBy=#ADDED_BY#>
							<cfset objResName.setID(addedBy)> -->
							<td align="center" style="word-wrap:break-word">{{cNote.addedBy}}<!-- #objResName.getName(addedBy, "@lName, @fName")# --></td> 
							<td align="center" ng-hide="${not isOCELead}"><input type="checkbox"  name="chkDelWrk" id="{{'chkDelWrk_'+cNote.workNoteID}}" value="{{cNote.workNoteID}}" <c:if test="${not isOCELead}">disabled</c:if>></td>
                        
							
						</tr>					
						<tr ng-if="collapsedNotesData.length==0">
                    	
                    	<td colspan="{{collapsenoteclass.iRAClient==1?7:6}}" align="center"><span class="errortext">No Notes Found</span></td>
					</tr>
			</tbody>
		</table>
		<div class="headtext" align="left" id="componentsRow" style="display:none; margin-left: 130px;">Component Level Notes:</div>
		<table id="tblComponetLvlNote" width="650px" class="dataTable smalltext" style="display:none; table-layout:fixed; margin-left: 130px;" >
			<colgroup>
				<col width="35"><!--- ## --->
				<col width="100"><!--- Category --->
				<col width="130"><!--- Requirement --->
				<col width="200"><!--- Notes --->
				<col width="70"><!--- Added On --->
				<col width="70"><!--- Added By --->
				<col width="45"><!--- Delete --->
				<tr ng-show="showRecordCount">
								<td align="right"><font size="2">Total number of
										records for selected criteria is</font> <font size="2" class="red">{{totalRecordsCount}}</font>
								</td>
							</tr>
			</colgroup>
			<!-- <cfoutput> -->
			<thead>				
				<tr bgcolor="#6699FF" class="headtext" align="center" style="color:#FFFFFF" nowrap>
					<th class="headtext"  width="35">##</th>
					<th class="headtext" width="100">
						Category<br>
						<img src="images/UpArrow.gif" ng-click="orderByField='category'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='category'; reversedSort = true" />
					</th>
					<th class="headtext" width="100">Requirement</th>
					<th class="headtext" width="200">Notes</th>
					<th class="headtext" width="70">
						Added On<br>
						<img src="images/UpArrow.gif" ng-click="orderByField='addedOnSort'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='addedOnSort'; reversedSort = true"/>
					</th>
					<th class="headtext" width="70">
						Added By<br>
						<img src="images/UpArrow.gif"  ng-click="orderByField='addedBy'; reversedSort = false" />
						<img src="images/DownArrow.gif" ng-click="orderByField='addedBy'; reversedSort = true" />
					</th>
					<th class="headtext" width="45" ng-hide="${not isOCELead}">Delete</th>
				</tr>
			</thead>
			
			<tbody>
                        <tr ng-repeat="eNote in expandedNotesData" >
                        <!---Release0616:End Change--->
							<td  align="center">{{$index+1}}</td>
							<td  align="center">{{categoryFilter[eNote.category]}}</td>
							<!-- <cfset objResName = fnGetResObj()> -->
							<td>{{eNote.addInfo}}</td>
							<td style="word-wrap:break-word">{{eNote.note}}</td>
							<td align="center">{{eNote.addedOn}}</td>
							<!-- <cfset addedBy=#ADDED_BY#>
							<cfset objResName.setID(addedBy)> -->
							<td align="center" style="word-wrap:break-word">{{eNote.addedBy}}</td>
							<td align="center" ng-hide="${not isOCELead}"><input type="checkbox"  name="chkDelComp" id="{{'chkDelComp_'+eNote.category+'_'+eNote.noteID}}" value="{{eNote.category+'_*_'+eNote.addInfo+'_*_'+eNote.noteID}}" <c:if test="${not isOCELead}">disabled</c:if> ></td>
							<!-- <cfset newlineFlag = true> -->
						</tr>
					<tr id="noRow" ng-if="expandedNotesData.length==0">
						<td colspan="7" align="center"><span class="errortext">No Notes Found</span></td>
					</tr>
			</tbody>
		</table>
			<div align="center">
				<ul class="pagination">
				<!--  <ul ng-if="vm.pager.pages.length" class="pagination"> -->
					
                <li ng-class="{disabled:vm.pager.currentPage === 1}">
                    <a ng-click="vm.setPage(1)">First</a>
                </li>
                <li ng-class="{disabled:vm.pager.currentPage === 1}">
                    <a ng-click="vm.setPage(vm.pager.currentPage - 1)">Previous</a>
                </li>
                <li ng-repeat="page in vm.pager.pages" ng-class="{active:vm.pager.currentPage === page}">
                    <a ng-click="vm.setPage(page)">{{page}}</a>
                </li>                
                <li ng-class="{disabled:vm.pager.currentPage === vm.pager.totalPages}">
                    <a ng-click="vm.setPage(vm.pager.currentPage + 1)">Next</a>
                </li>
                <li ng-class="{disabled:vm.pager.currentPage === vm.pager.totalPages}">
                    <a ng-click="vm.setPage(vm.pager.totalPages)">Last</a>
                </li>
            
				</ul>
			</div>
			<br><br>
        <div style="text-align:center;">
		<input type="button" id="btnDelete" name="btnDelete" class="btnBlue" ng-hide="${not isOCELead}" <c:if test="${NotOCELeadPersonnel}">disabled</c:if> value="Delete" ng-click="fnDelete();" style="text-align:center;" ng-disabled="{{isSpocEdit==0}}"/> &nbsp;&nbsp;
		<input type="button" id="btnSave" name="btnSave" class="btnBlue" <c:if test="${NotOCELeadPersonnel}">disabled</c:if> value="Save" ng-click="fnSave();" style="text-align:center;" ng-disabled="{{isSpocEdit==0}}" /> 
        <!---Release1115:End Change--->
		<input type="button" name="btnClose" value="Close" class="btnBlue" onClick="closePopup()" style="text-align:center;"/>
		</div>
		
	</div>
	</form>
	
</body>
</html>