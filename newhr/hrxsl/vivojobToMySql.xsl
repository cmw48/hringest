<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>

  <xsl:key name="kposnIdByValue" match="posnId" use="."/>
  <xsl:key name="ksupOrgRefIdByValue" match="supOrgRefId" use="."/>
  <xsl:key name="kKfsOrgCodeByValue" match="kfsOrgCode" use="."/>
<!-- created by cmw48 - creates a mysqldump formatted text file (*.sql) to load hr data into mySql tables -->
<!--
<xsl:template match="positions">
    -->

    <!--Select current element and all descendants  -->
  <!-- <xsl:apply-templates select="*"/> -->
  <!--xsl:value-of select="."/-->
  <!--  <xsl:if test="position()!=last()">),(</xsl:if>   
</xsl:template> -->
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>


  <xsl:template match="/positions">
    -- MySQL dump 10.13  Distrib 5.1.34, for unknown-linux-gnu (x86_64)
    --
    -- Host: localhost    Database: newhr_cmw48
    -- ------------------------------------------------------
    -- Server version       5.1.34-community
    
    /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
    /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
    /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
    /*!40101 SET NAMES utf8 */;
    /*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
    /*!40103 SET TIME_ZONE='+00:00' */;
    /*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
    /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
    /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
    /*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
    
    --
    -- Table structure for table `vivojob`
    --
    
    DROP TABLE IF EXISTS `vivojob`;
    /*!40101 SET @saved_cs_client     = @@character_set_client */;
    /*!40101 SET character_set_client = utf8 */;
    CREATE TABLE `vivojob` (
    `emplId` int(11) DEFAULT NULL,
    `posnId` varchar(255) DEFAULT NULL,
    `primaryJob` varchar(255) DEFAULT NULL,
    `jobCode` varchar(255) DEFAULT NULL,
    `posnTitle` varchar(255) DEFAULT NULL,
    `businessTitle` varchar(255) DEFAULT NULL,
    `company` varchar(255) DEFAULT NULL,
    `dLevelCode` varchar(255) DEFAULT NULL,
    `supOrgCode` varchar(255) DEFAULT NULL,
    `kfsOrgCode` varchar(255) DEFAULT NULL,
    `kfsOrgName` varchar(255) DEFAULT NULL,
    `dLevelOrgName` varchar(255) DEFAULT NULL,
    `supOrgId` varchar(255) DEFAULT NULL,
    `supOrgRefId` varchar(255) DEFAULT NULL,
    `supPositionId` varchar(255) DEFAULT NULL,    
    `supOrgName` varchar(255) DEFAULT NULL,    
    `supOrgHead` varchar(255) DEFAULT NULL,
    `supOrgType` varchar(255) DEFAULT NULL,    
    `unitId` varchar(255) DEFAULT NULL,
    `startDate` varchar(255) DEFAULT NULL,
    `jobFamily` varchar(255) DEFAULT NULL,
    `jobFamilyGroup` varchar(255) DEFAULT NULL,

    PRIMARY KEY USING BTREE (`posnId`),
    KEY `kfsOrgCode` (`kfsOrgCode`) USING BTREE,
    KEY `emplId` (`emplId`) USING BTREE
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    /*!40101 SET character_set_client = @saved_cs_client */;
    
    --
    -- Dumping data for table `vivojob`
    --
    
    LOCK TABLES `vivojob` WRITE;
    /*!40000 ALTER TABLE `vivojob` DISABLE KEYS */;
    
    INSERT INTO `vivojob` VALUES <xsl:for-each-group select="position" group-by="posnId | posnId">('<xsl:value-of select="emplId"/>','<xsl:value-of select="posnId"/>','<xsl:value-of select="primaryJob"/>','<xsl:value-of select="jobCode"/>','<xsl:value-of select="posnTitle"/>','<xsl:value-of select="businessTitle"/>','<xsl:value-of select="company"/>','<xsl:value-of select="dLevelCode"/>','<xsl:value-of select="supOrgCode"/>','<xsl:value-of select="kfsOrgCode"/>','<xsl:value-of select="kfsOrgName"/>','<xsl:value-of select="dLevelOrgName"/>','<xsl:value-of select="supOrgId"/>','<xsl:value-of select="supOrgRefId"/>','<xsl:value-of select="supPositionId"/>','<xsl:value-of select="supOrgName"/>','<xsl:value-of select="supOrgHead"/>','<xsl:value-of select="supOrgType"/>','<xsl:value-of select="unitId"/>','<xsl:value-of select="startDate"/>','<xsl:value-of select="jobFamily"/>','<xsl:value-of select="jobFamilyGroup"/>')<xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each-group><xsl:if test="position()!=last()">,</xsl:if>;
    /*!40000 ALTER TABLE `vivojob` ENABLE KEYS */;
    UNLOCK TABLES;
    /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
    
    /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
    /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
    /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
    /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
    /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
    /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
    /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
    --
    -- Table structure for table `vivowdorg`
    --
    
    DROP TABLE IF EXISTS `vivowdorg`;
    /*!40101 SET @saved_cs_client     = @@character_set_client */;
    /*!40101 SET character_set_client = utf8 */;
    CREATE TABLE `vivowdorg` (
    `dLevelCode` varchar(255) DEFAULT NULL,
    `supOrgCode` varchar(255) DEFAULT NULL,
    `kfsOrgCode` varchar(255) DEFAULT NULL,
    `supOrgId` varchar(255) DEFAULT NULL,
    `supOrgRefId` varchar(255) DEFAULT NULL,
    `supPositionId` varchar(255) DEFAULT NULL,
    `supOrgName` varchar(255) DEFAULT NULL,
    `supOrgHead` varchar(255) DEFAULT NULL,
    `supOrgType` varchar(255) DEFAULT NULL,
    `deptCode` varchar(255) DEFAULT NULL,
    `unitId` varchar(255) DEFAULT NULL,
    
    PRIMARY KEY USING BTREE (`supOrgRefId`),
    KEY `kfsOrgCode` (`kfsOrgCode`) USING BTREE
    ) ENGINE=MyISAM DEFAULT CHARSET=latin1;
    /*!40101 SET character_set_client = @saved_cs_client */;
    
    --
    -- Dumping data for table `vivowdorg`
    --
    
    LOCK TABLES `vivowdorg` WRITE;
    /*!40000 ALTER TABLE `vivowdorg` DISABLE KEYS */;
    INSERT INTO `vivowdorg` VALUES <xsl:for-each-group select="position" group-by="supOrgRefId | supOrgRefId">('<xsl:value-of select="dLevelCode"/>','<xsl:value-of select="supOrgCode"/>','<xsl:value-of select="kfsOrgCode"/>','<xsl:value-of select="supOrgId"/>','<xsl:value-of select="supOrgRefId"/>','<xsl:value-of select="supPositionId"/>','<xsl:value-of select="supOrgName"/>','<xsl:value-of select="supOrgHead"/>','<xsl:value-of select="supOrgType"/>','<xsl:value-of select="deptCode"/>','<xsl:value-of select="unitId"/>')<xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each-group><xsl:if test="position()!=last()">,</xsl:if>;
    /*!40000 ALTER TABLE `vivowdorg` ENABLE KEYS */;
    UNLOCK TABLES;
    /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
    
    /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
    /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
    /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
    /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
    /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
    /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
    /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
    

--
-- Table structure for table `vivokfsorg`
--

DROP TABLE IF EXISTS `vivokfsorg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vivokfsorg` (
`dLevelCode` varchar(255) DEFAULT NULL,
`supOrgCode` varchar(255) DEFAULT NULL,
`kfsOrgCode` varchar(255) DEFAULT NULL,
`kfsOrgName` varchar(255) DEFAULT NULL,
`dLevelOrgName` varchar(255) DEFAULT NULL,
`supOrgRefId` varchar(255) DEFAULT NULL,
`supPositionId` varchar(255) DEFAULT NULL,
`supOrgName` varchar(255) DEFAULT NULL,

PRIMARY KEY USING BTREE (`kfsOrgCode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vivokfsorg`
--

LOCK TABLES `vivokfsorg` WRITE;
/*!40000 ALTER TABLE `vivokfsorg` DISABLE KEYS */;
INSERT INTO `vivokfsorg` VALUES <xsl:for-each-group select="position" group-by="kfsOrgCode | kfsOrgCode">('<xsl:value-of select="dLevelCode"/>','<xsl:value-of select="supOrgCode"/>','<xsl:value-of select="kfsOrgCode"/>','<xsl:value-of select="kfsOrgName"/>','<xsl:value-of select="dLevelOrgName"/>','<xsl:value-of select="supOrgRefId"/>','<xsl:value-of select="supPositionId"/>','<xsl:value-of select="supOrgName"/>')<xsl:if test="position()!=last()">,</xsl:if>
</xsl:for-each-group><xsl:if test="position()!=last()">,</xsl:if>;
    /*!40000 ALTER TABLE `vivokfsorg` ENABLE KEYS */;
    UNLOCK TABLES;
    /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
    
    /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
    /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
    /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
    /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
    /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
    /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
    /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
    


  </xsl:template>
 
  

</xsl:stylesheet>
