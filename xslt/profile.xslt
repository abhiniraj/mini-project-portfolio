<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/profile">
    <div class="xslt-profile">
      <h3><xsl:value-of select="name"/></h3>
      <p>
        <strong>Location:</strong> <xsl:value-of select="contact/location"/><br/>
        <strong>Phone:</strong> <xsl:value-of select="contact/phone"/><br/>
        <strong>Email:</strong> <xsl:value-of select="contact/email"/>
      </p>
      <p><xsl:value-of select="bio"/></p>
      <h4>Education</h4>
      <p><xsl:value-of select="education/degree"/> — <xsl:value-of select="education/college"/> (<xsl:value-of select="education/years"/>)</p>
      <h4>Skills</h4>
      <ul>
        <xsl:for-each select="skills/skill">
          <li><xsl:value-of select="."/></li>
        </xsl:for-each>
      </ul>
      <h4>Projects</h4>
      <ul>
        <xsl:for-each select="projects/project">
          <li><strong><xsl:value-of select="title"/></strong>: <xsl:value-of select="desc"/></li>
        </xsl:for-each>
      </ul>
    </div>
  </xsl:template>
</xsl:stylesheet>
