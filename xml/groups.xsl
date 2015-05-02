  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/TR/WD-xsl">
  <xsl:template match="/">
  <table border="1">
  <tr bgcolor="#CCCCCC">
  <td align="center"><strong><xsl:value-of select="//groupsCaptionName"/></strong></td>
  </tr>
  <xsl:for-each select="tutorial/enimals/groups/group">
  <tr bgcolor="#F5F5F5">
  <td><xsl:value-of select="groupName"/></td>
  </tr>
  </xsl:for-each>
  </table>
  </xsl:template>
  </xsl:stylesheet>