<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:vfx="http://vivoweb.org/ext/functions" xmlns:wd="urn:com.workday.report/VIVO_Job"
	xmlns:hr="http://vivo.cornell.edu/ns/hr/0.9/hr.owl#"
	xmlns:rdfsyn="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	exclude-result-prefixes="xs vfx wd env hr rdfsyn">
	
	<!-- created by jrm424, edited by cmw48 to align to mySql field names and format -->

	<xsl:param name="xref" required="no"/>
	<!-- xsl:param name='extOrgIn' required='yes'/ -->

	<xsl:variable name="xrf" select="document($xref)/rdfsyn:RDF/rdfsyn:Description"/>

	<xsl:output method="xml" indent="yes" normalization-form="NFC"/>
	<xsl:strip-space elements="*"/>

	<!-- we need to escape any apostrophes we find, 
		use these variables to find and replace -->

	<xsl:variable name="aposPattern">
		<xsl:text>'</xsl:text>
	</xsl:variable>
	<xsl:variable name="escAposPattern">
		<xsl:text>''</xsl:text>
	</xsl:variable>

	<!--  not used if converting to D2R, we'll create all URI and types there
	
	<xsl:variuseable name="extantOrgs" select="document($extOrgIn)/ExtantOrgs"/> 

	<xsl:variable name="pospfx" select='"http://vivo.cornell.edu/individual/posn"'/>
	<xsl:variable name="primpos" select='"http://vivoweb.org/ontology/core#PrimaryPosition"'/>
	
	-->

	<xsl:template match="/env:Envelope/env:Body/wd:Report_Data">

		<positions>
			<xsl:for-each select="wd:Report_Entry">

				<xsl:for-each select="wd:All_Positions___Jobs">
					<position>

						<xsl:variable name="eid" select="../wd:Worker/wd:Employee_ID"/>
						<emplId>
							<xsl:value-of select="$eid"/>
						</emplId>

						<posnId>
							<xsl:value-of select="wd:Position_ID"/>
						</posnId>

						<!--  not used, if we're using D2R then we'll create URI and types there
						
						<xsl:variable name="uri" select="$xrf[hr:emplId = $eid]/@rdfsyn:about"/>
						
						<personUri>
						<xsl:value-of select='$uri'/>
						</personUri>

						<xsl:variable name='orgUri' 
							select='$extantOrgs/org[normalize-space(upper-case(name)) = normalize-space(upper-case($s))]/uri'/>
							
						<posnUri>
							<xsl:value-of select='concat($pospfx,wd:Position_ID)'/>
						</posnUri>

						<posnDtiUri>
							<xsl:value-of select='concat($pospfx,wd:Position_ID,"-DTI")'/>
						</posnDtiUri>

						<posnDtiEndUri>
							<xsl:value-of select='concat($pospfx,wd:Position_ID,"-DTI-E")'/>
						</posnDtiEndUri>

						<posnDtiStartUri>
							<xsl:value-of select='concat($pospfx,wd:Position_ID,"-DTI-S")'/>
						</posnDtiStartUri>	

						<primaryJob>
							<xsl:value-of select='if(wd:Primary_Job = "1") then $primpos else ""'/>
						</primaryJob>
						-->

						<primaryJob>
							<xsl:value-of select='if(wd:Primary_Job = "1") then "P" else "S"'/>
						</primaryJob>

						<jobCode>
							<xsl:value-of select="wd:Job_Code"/>
						</jobCode>

						<posnTitle>
							<xsl:value-of select="wd:Position_Title"/>
						</posnTitle>

						<xsl:variable name="busTitle"
							select="wd:Business_Title"/>
						
						<!-- correct businessTitle - remove parentheses from business title field when they appear -->
						<xsl:variable name="busTitleParen"
							select='normalize-space(substring-before($busTitle,"("))'/>

						<xsl:choose>
							<xsl:when test="$busTitleParen = ''">
								<xsl:variable name="busTitleCorrect"
									select="wd:Business_Title"/>

								<businessTitle>
									<xsl:value-of
										select="replace($busTitleCorrect, $aposPattern, $escAposPattern)" />
								</businessTitle>
							</xsl:when>

							<xsl:otherwise>
								<xsl:variable name="busTitleCorrect"
									select='normalize-space(substring-before($busTitle,"("))'/>

								<businessTitle>
									<xsl:value-of
										select="replace($busTitleCorrect, $aposPattern, $escAposPattern)" />
								</businessTitle>
							</xsl:otherwise>

						</xsl:choose>

						<!-- determine if ENDowed or STAtutory based on text in company tag -->
						<company>
							<xsl:value-of
								select='if(wd:Company_-_Name = "Cornell Univ (NYS Colleges &amp; Exper Sta)") then "STA" else 
								if(wd:Company_-_Name = "Cornell University") then "END" else ""'/>
						</company>

						<!-- no longer used in D2R
						<companyName>
							<xsl:value-of select='wd:Company_-_Name'/>
						</companyName> -->
						<!-- if any part of the KFSOrgCode is blank, insert 0000 -->
						<xsl:variable name="KfsOrgStringLength"
							select='(string-length(wd:KFS_Org))'/>	
						<xsl:choose>
							<xsl:when test="$KfsOrgStringLength = 0">
								<kfsOrgCode>
									<xsl:value-of select='"0000-0000"' />
								</kfsOrgCode>			
								<supOrgCode>
									<xsl:value-of select="'0000'" />
								</supOrgCode>
								<dLevelCode>
									<xsl:value-of select="'0000'" />
								</dLevelCode>
							</xsl:when>
							<xsl:otherwise>
							  <xsl:choose>
								<xsl:when test="$KfsOrgStringLength &lt; 9">
									<kfsOrgCode>
										<xsl:value-of select="concat(wd:KFS_Org, '-', '0000')" />
									</kfsOrgCode>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="$KfsOrgStringLength = 9">
										<kfsOrgCode>
											<xsl:value-of select="wd:KFS_Org" />
										</kfsOrgCode>
										<supOrgCode>
											<xsl:value-of select='substring-before(wd:KFS_Org,"-")'/>
										</supOrgCode>
										<dLevelCode>
											<xsl:value-of select='substring-after(wd:KFS_Org,"-")'/>
										</dLevelCode>
									</xsl:if>	
								</xsl:otherwise>
								</xsl:choose>	
							</xsl:otherwise>
						</xsl:choose>
	
						
				

						<xsl:variable name="kfsOrgName" select="wd:KFS_Org_Name/@wd:Descriptor"/>

						<kfsOrgName>
							<xsl:variable name="kfsOrgNameString"
								select="wd:KFS_Org_Name/@wd:Descriptor"/>
							<xsl:value-of
								select="replace($kfsOrgNameString, $aposPattern, $escAposPattern)"/>
						</kfsOrgName>

						<dLevelOrgName>
 							<xsl:variable name="dLevelOrgNameString"
								select='normalize-space(substring-after($kfsOrgName," "))'/>
							<xsl:value-of
								select="replace($dLevelOrgNameString, $aposPattern, $escAposPattern)" />
						</dLevelOrgName>
						
						<supOrgId>
							<xsl:value-of
							  select="wd:Supervisory_Organization/wd:ID[1]"/>
						</supOrgId>

                        <xsl:variable name="supOrgRefId"
                               select="wd:Supervisory_Organization/wd:ID[2]"/>


                         <supOrgRefId>
                             <xsl:value-of
                                select="$supOrgRefId"/>
                         </supOrgRefId>
						
						<supPositionId>
                        <xsl:value-of
                            select='normalize-space(substring-after($supOrgRefId, "-"))'/>
						</supPositionId>
							

						<!-- several things are derived from the supOrg descriptor -->
						<xsl:variable name="supOrg"
							select="wd:Supervisory_Organization/@wd:Descriptor"/>

						<xsl:variable name="supOrgNameString"
							select='normalize-space(substring-after(substring-before($supOrg,"("),"-"))' />

						<supOrgName>
							<xsl:value-of
								select="replace($supOrgNameString, $aposPattern, $escAposPattern)"/>
						</supOrgName>
						
						<!-- get unit head name and unit type from what's left over in supOrg descriptor -->

						<xsl:variable name="supOrgHeadNameCleaned">
							<xsl:value-of
								select='normalize-space(substring-before(substring-after(substring-before($supOrg,")"),"("), "("))' />
						</xsl:variable>

						<xsl:variable name="supOrgHeadName">
							<xsl:value-of
								select='normalize-space(substring-after(substring-before($supOrg,")"),"("))' />
						</xsl:variable>

						<!-- escape any apostrophes that appear in names - they don't play nice with mySql -->
						<xsl:choose>
							<xsl:when test="$supOrgHeadNameCleaned = ''">
								<supOrgHead>
									<xsl:value-of
										select="replace($supOrgHeadName, $aposPattern, $escAposPattern)" />
								</supOrgHead>
							</xsl:when>
							<xsl:otherwise>
								<supOrgHead>
									<xsl:value-of
										select="replace($supOrgHeadNameCleaned, $aposPattern, $escAposPattern)" />
								</supOrgHead>
							</xsl:otherwise>
						</xsl:choose>

						<!-- get the unit suffix (HC, SUBD, SUBU, DEPT, or not included) -->
						<xsl:variable name="supOrgString">
							<xsl:value-of
								select='normalize-space(substring-after(substring-before($supOrg," (")," "))' />
						</xsl:variable>
						
						<xsl:variable name="lenSupOrgType">
							<xsl:value-of
									select='(string-length($supOrgString))' />
						</xsl:variable>
						
						<xsl:variable name="supOrgPart">
							<xsl:value-of
								select='substring($supOrgString, (($lenSupOrgType)-4), $lenSupOrgType)' />
						</xsl:variable>

						<xsl:variable name="supOrgAbbr">
							<xsl:value-of
								select='substring-after($supOrgPart, " ")' />
						</xsl:variable>

						<supOrgType>
							<xsl:value-of
								select="normalize-space($supOrgAbbr)"/>
						</supOrgType>

						<deptCode>
							<xsl:value-of select="wd:Supervisory_Organization_Code"/>
						</deptCode>

						<unitId>
							<xsl:value-of select="wd:CU_College_Unit"/>
						</unitId>

						<startDate>
							<xsl:value-of select="wd:Assignment_Start_Date"/>
						</startDate>

						<jobFamily>
							<xsl:value-of select="wd:Job_Families/@wd:Descriptor"/>
						</jobFamily>

						<jobFamilyGroup>
							<xsl:value-of select="wd:Job_Family_Group/@wd:Descriptor"/>
						</jobFamilyGroup>


					</position>
				</xsl:for-each>


			</xsl:for-each>
		</positions>
		<xsl:text>
</xsl:text>
	</xsl:template>

</xsl:stylesheet>
