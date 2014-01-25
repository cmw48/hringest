<?xml version="1.0"?>
<xsl:stylesheet version='2.0'
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs='http://www.w3.org/2001/XMLSchema'
	xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:vfx='http://vivoweb.org/ext/functions'
	xmlns:wd="urn:com.workday.report/INT216C_Terms"
	exclude-result-prefixes='xs vfx wd env'	>
<xsl:output method='xml' indent='yes' normalization-form='NFC'/>
<xsl:strip-space elements="*"/>
	
<!-- created by jrm424, edited by cmw48 to align to mySql field names and data requirements -->
	
<xsl:template match='/env:Envelope/env:Body/wd:Report_Data'>
<terminations>
<!--xsl:for-each select='wd:Report_Entry'-->
<xsl:for-each-group select='wd:Report_Entry' group-by='wd:Position_ID'>
<xsl:sort select='wd:Effective_Date'/>
<termination>

<!-- setup pattern to escape apostrophes in name data and org names -->
<xsl:variable name="aposPattern">
	<xsl:text>'</xsl:text>
</xsl:variable>
<xsl:variable name="escAposPattern">
	<xsl:text>''</xsl:text>
</xsl:variable>

<emplId>
<xsl:value-of select='wd:Worker/wd:Employee_ID'/>
</emplId>
	
<posnId>
	<xsl:value-of select='wd:Position_ID'/>
</posnId>	

<xsl:variable name="busProcEvent"
	select='wd:Business_Process_Event/@wd:Descriptor'/>
	
<event>
	<xsl:value-of select='normalize-space(substring-before($busProcEvent,":"))'/>
</event>

<xsl:variable name="busProcEventEmplName"
	select='normalize-space(substring-after($busProcEvent,": "))'/>

<xsl:variable name="retActive"
	select='normalize-space(substring-after(substring-before($busProcEventEmplName,")"),"("))'/>

<retActive>
	<xsl:value-of select='$retActive'/>
</retActive>

<xsl:variable name="busProcEventEmplNameCleaned"
	select='normalize-space(substring-before($busProcEventEmplName," ("))'/>

<xsl:choose>
	<xsl:when test="$retActive = ''">
		<emplFullName>
			<xsl:value-of select="replace($busProcEventEmplName, $aposPattern, $escAposPattern)"></xsl:value-of>
		</emplFullName>	
	</xsl:when>
	<xsl:otherwise>
		<emplFullName>
			<xsl:value-of select="replace($busProcEventEmplNameCleaned, $aposPattern, $escAposPattern)"></xsl:value-of>
		</emplFullName>	
	</xsl:otherwise>
</xsl:choose>

<effDate>
	<xsl:value-of select='wd:Effective_Date'/>
</effDate>	

<hireDate>
<xsl:value-of select='wd:Worker/wd:Original_Hire_Date'/>
</hireDate>

<contServDate>
<xsl:value-of select='wd:Worker/wd:Continuous_Service_Date'/>
</contServDate>

<currentlyActive>
<xsl:value-of
	 select='if(wd:Worker/wd:Currently_Active = "1") then "Y" else "N"'/>
</currentlyActive>

<jobCode>
<xsl:value-of select='wd:Worker/wd:Job_Code'/>
</jobCode>

<jobCodeFamily>
<xsl:value-of select='wd:Worker/wd:Job_Family_Code'/>
</jobCodeFamily>

<xsl:variable name="reasonDesc"
	select='wd:Business_Process_Reason/@wd:Descriptor'/>

<reason>
	<xsl:value-of select='normalize-space(substring-after(substring-after($reasonDesc,"&gt; "), "&gt; "))'/>
</reason>

</termination>
<!--/xsl:for-each-->
</xsl:for-each-group>
</terminations>
<xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
