<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:vfx="http://vivoweb.org/ext/functions" xmlns:wd="urn:com.workday.report/VIVO_Person"
	exclude-result-prefixes="xs vfx">

	<!-- created by jrm424, edited by cmw48 to align with mySql database fields and data requirements  -->

	<xsl:output method="xml" indent="yes" normalization-form="NFC"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="/env:Envelope/env:Body/wd:Report_Data">

		<!-- create variables to be used to escape apostrophes in data -->
		<xsl:variable name="aposPattern">
			<xsl:text>'</xsl:text>
		</xsl:variable>

		<xsl:variable name="escAposPattern">
			<xsl:text>\\'</xsl:text>
		</xsl:variable>

		<persons>
			<xsl:for-each select="wd:Report_Entry">
				<xsl:if test='string(wd:Netid) != ""'>
					<person>

						<emplId>
							<xsl:value-of select="wd:Employee_ID"/>
						</emplId>


						<netId>
							<xsl:value-of select="wd:Netid"/>
						</netId>


						<legalFirstName>
							<xsl:variable name="legalFirstName"
								select="string(wd:Legal_Name_-_First_Name)"/>
							<xsl:value-of
								select="replace($legalFirstName, $aposPattern, $escAposPattern)"/>
						</legalFirstName>

						<!-- if legalMiddleName is not blank, create legalMiddleInitial -->
						<xsl:if test='string(wd:Legal_Name_-_Middle_Name) != ""'>
							
							<xsl:variable name="legalMiddleName"
								select="string(wd:Legal_Name_-_Middle_Name)"/>

							<legalMiddleName>
								<xsl:value-of
									select="replace($legalMiddleName, $aposPattern, $escAposPattern)"/>
							</legalMiddleName>
							
							<legalMiddleInitial>
								<xsl:value-of select="substring($legalMiddleName, 1, 1)"/>
							</legalMiddleInitial>

						</xsl:if>

						<legalLastName>
							<xsl:variable name="legalLastName"
								select="string(wd:Legal_Name_-_Last_Name)"/>
							<xsl:value-of
								select="replace($legalLastName, $aposPattern, $escAposPattern)"/>
						</legalLastName>

						<!-- we dropped legalSalutation because it's not populated in the data we get from HR-->

						<xsl:if test='string(wd:Legal_Name_-_Social_Suffix) != ""'>
							<legalSocialSuffix>
								<xsl:value-of select="wd:Legal_Name_-_Social_Suffix"/>
							</legalSocialSuffix>
						</xsl:if>

						<xsl:variable name="preferredFirstName"
							select="string(wd:Preferred_Name_-_First_Name)"/>

						<xsl:variable name="correctedPrefFirstName"
							select="replace($preferredFirstName, $aposPattern, $escAposPattern)"/>

						<preferredFirstName>
							<xsl:value-of
								select="replace($preferredFirstName, $aposPattern, $escAposPattern)"/>
						</preferredFirstName>

						<xsl:variable name="preferredMiddleName"
							select="string(wd:Preferred_Name_-_Middle_Name)"/>

						<xsl:if test='$preferredMiddleName != ""'>
							<xsl:variable name="preferredMiddleName"
								select="string(wd:Preferred_Name_-_Middle_Name)"/>

							<preferredMiddleName>
								<xsl:value-of
									select="replace($preferredMiddleName, $aposPattern, $escAposPattern)"/>
							</preferredMiddleName>
							<!-- added logic for preferredMiddleInitial here -->
						</xsl:if>

						<preferredMiddleInitial>
							<xsl:value-of select="substring($preferredMiddleName, 1, 1)"/>
						</preferredMiddleInitial>

						<xsl:variable name="preferredMiddleInitial"
							select="substring($preferredMiddleName, 1, 1)"/>

						<xsl:variable name="preferredLastName"
							select="string(wd:Preferred_Name_-_Last_Name)"/>

						<xsl:variable name="correctedPrefLastName"
							select="replace($preferredLastName, $aposPattern, $escAposPattern)"/>

						<preferredLastName>
							<xsl:value-of
								select="replace($preferredLastName, $aposPattern, $escAposPattern)"/>
						</preferredLastName>

						<xsl:variable name="preferredSocialSuffix">
							<xsl:if test='string(wd:Preferred_Name_-_Social_Suffix) != ""'>
								<xsl:value-of select="string(wd:Preferred_Name_-_Social_Suffix)"/>
							</xsl:if>
						</xsl:variable>

						<xsl:if test='string(wd:Preferred_Name_-_Social_Suffix) != ""'>
							<preferredSocialSuffix>
								<xsl:value-of select="wd:Preferred_Name_-_Social_Suffix"/>
							</preferredSocialSuffix>
						</xsl:if>

						<!-- manufacture preferredNameLabel here? -->
						<xsl:variable name="preferredNameLabel">
							<xsl:choose>
								<xsl:when test='string(wd:Preferred_Name_-_Social_Suffix) != ""'>
									<!-- prefSocSuf is not blank -->
									<xsl:choose>
										<xsl:when
											test='string(wd:Preferred_Name_-_Middle_Name) != ""'>
											<!-- prefMiddleName is not blank -->
											<xsl:choose>
												<xsl:when
												test='string(wd:Preferred_Name_-_Social_Suffix) = "Jr" or string(wd:Preferred_Name_-_Social_Suffix) = "Sr" or string(wd:Preferred_Name_-_Social_Suffix) = "Esq"'>
												<!-- suffix is Jr or suffix is Sr, add period at end of label -->
												<xsl:value-of
												select="concat($correctedPrefLastName, ', ', $correctedPrefFirstName, ' ', $preferredMiddleInitial, '., ', $preferredSocialSuffix, '.')"
												/>
												</xsl:when>
												<xsl:otherwise>
												<!-- suffix is not Jr or Sr, don't add period at end of label -->
												<xsl:value-of
												select="concat($correctedPrefLastName, ', ', $correctedPrefFirstName, ' ', $preferredMiddleInitial, '., ', $preferredSocialSuffix)"
												/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<!-- prefMiddleName is blank, but append suffix -->
											<xsl:choose>
												<xsl:when
												test='string(wd:Preferred_Name_-_Social_Suffix) = "Jr" or string(wd:Preferred_Name_-_Social_Suffix) = "Sr" or string(wd:Preferred_Name_-_Social_Suffix) = "Esq"'>
												<!-- suffix is Jr or suffix is Sr, add period at end of label -->
												<xsl:value-of
												select="concat($correctedPrefLastName, ', ', $correctedPrefFirstName, ', ', $preferredSocialSuffix, '.')"
												/>
												</xsl:when>
												<xsl:otherwise>
												<!-- suffix is not Jr or Sr, don't add period at end of label -->
												<xsl:value-of
												select="concat($correctedPrefLastName, ', ', $correctedPrefFirstName, ', ', $preferredSocialSuffix)"
												/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<!-- if prefSocSuf is blank -->
									<xsl:choose>
										<xsl:when
											test='string(wd:Preferred_Name_-_Middle_Name) != ""'>
											<xsl:value-of
												select="concat($correctedPrefLastName, ', ', $correctedPrefFirstName, ' ', $preferredMiddleInitial, '.')"
											/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of
												select="concat($correctedPrefLastName, ', ',$correctedPrefFirstName)"
											/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<!-- manufacture preferredNameString here? -->
						<xsl:variable name="preferredNameString">
							<xsl:choose>
								<xsl:when test='string(wd:Preferred_Name_-_Social_Suffix) != ""'>
									<!-- prefSocSuf is not blank -->
									<xsl:choose>
										<xsl:when
											test='string(wd:Preferred_Name_-_Middle_Name) != ""'>
											<!-- prefMiddleName is not blank -->
											<xsl:choose>
												<xsl:when
													test='string(wd:Preferred_Name_-_Social_Suffix) = "Jr" or string(wd:Preferred_Name_-_Social_Suffix) = "Sr" or string(wd:Preferred_Name_-_Social_Suffix) = "Esq"'>
													<!-- suffix is Jr or suffix is Sr, add period at end of label -->
													<xsl:value-of
														select="concat($correctedPrefFirstName, ' ', $preferredMiddleInitial, '. ', $correctedPrefLastName, ', ', $preferredSocialSuffix, '.')"
													/>
												</xsl:when>
												<xsl:otherwise>
													<!-- suffix is not Jr or Sr, don't add period at end of label -->
													<xsl:value-of
														select="concat($correctedPrefFirstName, ' ', $preferredMiddleInitial, '. ', $correctedPrefLastName, ' ', $preferredSocialSuffix)"
													/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<!-- prefMiddleName is blank, but append suffix -->
											<xsl:choose>
												<xsl:when
													test='string(wd:Preferred_Name_-_Social_Suffix) = "Jr" or string(wd:Preferred_Name_-_Social_Suffix) = "Sr" or string(wd:Preferred_Name_-_Social_Suffix) = "Esq"'>
													<!-- suffix is Jr or suffix is Sr, add period at end of label -->
													<xsl:value-of
														select="concat($correctedPrefFirstName, ' ', $correctedPrefLastName, ', ', $preferredSocialSuffix, '.')"
													/>
												</xsl:when>
												<xsl:otherwise>
													<!-- suffix is not Jr or Sr, don't add period at end of label -->
													<xsl:value-of
														select="concat($correctedPrefFirstName, ' ' ,$correctedPrefLastName, ' ', $preferredSocialSuffix)"
													/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<!-- if prefSocSuf is blank -->
									<xsl:choose>
										<xsl:when
											test='string(wd:Preferred_Name_-_Middle_Name) != ""'>
											<xsl:value-of
												select="concat($correctedPrefFirstName, ' ' , $preferredMiddleInitial, '. ' ,$correctedPrefLastName)"
											/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of
												select="concat($correctedPrefFirstName, ' ', $correctedPrefLastName)"
											/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						

						<preferredNameLabel>
							<xsl:value-of select="$preferredNameLabel"/>
						</preferredNameLabel>

						<preferredNameString>
							<xsl:value-of select="$preferredNameString"/>
						</preferredNameString>

						<!-- drop preferredSalutation because it's not populated in the data we get from HR -->

					</person>
				</xsl:if>
			</xsl:for-each>
		</persons>
	</xsl:template>
</xsl:stylesheet>
