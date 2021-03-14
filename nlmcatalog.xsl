<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    <!--<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">-->
        

    <xsl:template match="NLMCatalogRecordSet">
        <html>
            <head>
                <title>NLM Catalog Database output</title>
            </head>
            
            <body>
                <h2>Table of serial records from XML</h2>
                
                <p>The source data has more elements than this; these appear to be useful for most purposes.</p>
                
                <table border="1">
                    <tr>
                        <th scope="col">NlmUniqueID</th>
                        <th scope="col">Title</th>
                        <th scope="col">MedlineTitleAbbreviation</th>
                        <th scope="col">CollectiveAuthorName</th>
                        <th scope="col">Publisher</th>
                        <th scope="col">PublicationCountry</th>
                        <th scope="col">PublicationPlace</th>
                        <th scope="col">PublicationStartYear</th>
                        <th scope="col">PublicationEndYear</th>
                        <th scope="col">PublicationFrequency</th>
                        <th scope="col">Description</th>
                        <th scope="col">Language</th>
                        <th scope="col">ISSN</th>
                        <th scope="col">Coden</th>
                        <th scope="col">LCCN</th>
                        <th scope="col">ElectronicLinks</th>
                        <th scope="col">IndexingSources</th>
                        <th scope="col">MeSH</th>
                        <th scope="col">CrossReferences</th>
                        <th scope="col">PublicationType</th>
                        <th scope="col">GeneralNotes</th>
                    </tr>
                    <xsl:apply-templates/>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="NCBICatalogRecord">
        <tr>
            <!-- NlmUniqueID -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/NlmUniqueID"/></td>
            <!-- Title -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/Title"/></td>
            <!-- MedlineTitleAbbreviation -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/MedlineTA"/></td>
            <!-- CollectiveAuthorName -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="NLMCatalogRecord/AuthorList/Author"><xsl:value-of select="NLMCatalogRecord/AuthorList/Author/CollectiveName"/></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- Publisher -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/PublicationInfo/Publisher"/></td>
            <!-- PublicationCountry -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/PublicationInfo/Country"/></td>
            <!-- PublicationPlace -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/PublicationInfo/Place"/></td>
            <!-- PublicationStartYear -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/PublicationInfo/PublicationFirstYear"/></td>
            <!-- PublicationEndYear -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="JrXml/Serial/PublicationInfo/PublicationEndYear"><xsl:value-of select="JrXml/Serial/PublicationInfo/PublicationEndYear"/></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- PublicationFrequency -->
            <td valign="top"><xsl:value-of select="JrXml/Serial/PublicationInfo/Frequency"/></td>
            <!-- Description -->
            <td valign="top">
                <xsl:for-each select="NLMCatalogRecord/PhysicalDescription/Form">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
                <xsl:for-each select="NLMCatalogRecord/PhysicalDescription/Extent">
                    <xsl:apply-templates select="."/>
                </xsl:for-each>
            </td>
            <!-- Language -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="JrXml/Serial/Language"><xsl:for-each select="JrXml/Serial/Language"><xsl:value-of select="."/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- ISSN -->
            <td valign="top">
                <xsl:for-each select="NLMCatalogRecord/ISSN"><xsl:value-of select="."/> (<xsl:value-of select="@IssnType"/>)<xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each>
            </td>
            <!-- Coden -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="NLMCatalogRecord/Coden"><xsl:for-each select="NLMCatalogRecord/Coden"><xsl:value-of select="."/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- LCCN -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="NLMCatalogRecord/LCCN"><xsl:for-each select="NLMCatalogRecord/LCCN"><xsl:value-of select="."/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- ElectronicLinks -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="NLMCatalogRecord/ELocationList/ELocation"><xsl:for-each select="NLMCatalogRecord/ELocationList/ELocation"><xsl:value-of select="DescriptiveInformation"/>: <xsl:value-of select="ELocationID"/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- IndexingSources -->
            <td valign="top">
                <xsl:for-each select="NLMCatalogRecord/IndexingSourceList/IndexingSource">
                    <xsl:value-of select="IndexingSourceName"/>, <xsl:value-of select="IndexingSourceName/@IndexingTreatment"/>, <xsl:value-of select="Coverage"/><xsl:if test="not(position() = last())">; </xsl:if>
                </xsl:for-each>
            </td>            
            <!-- MeSH -->
            <td valign="top">
                <xsl:for-each select="JrXml/Serial/MeshHeadingList/MeshHeading"><xsl:value-of select="DescriptorName"/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each>
            </td>
            <!-- CrossReferences -->
            <td valign="top">
                <xsl:for-each select="JrXml/Serial/CrossReferenceList/CrossReference"><xsl:value-of select="XrTitle"/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each>
            </td>
            <!-- PublicationType -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="NLMCatalogRecord/PublicationTypeList/PublicationType"><xsl:for-each select="NLMCatalogRecord/PublicationTypeList/PublicationType"><xsl:value-of select="."/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
            <!-- GeneralNotes -->
            <td valign="top">
                <xsl:choose>
                    <xsl:when test="NLMCatalogRecord/GeneralNote"><xsl:for-each select="NLMCatalogRecord/GeneralNote"><xsl:value-of select="."/><xsl:if test="not(position() = last())">; </xsl:if></xsl:for-each></xsl:when>
                    <xsl:otherwise><xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>
