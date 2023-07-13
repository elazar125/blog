<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
  <html xmlns="http://www.w3.org/1999/xhtml" lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />

      <title>RSS Feed | <xsl:value-of select="/atom:feed/atom:title"/></title>

      <link rel="icon" href="/favicon.ico" sizes="any" />
      <link rel="icon" href="/icon.svg" type="image/svg+xml" />
      <link rel="apple-touch-icon" href="/icon.png" />

      <link rel="stylesheet" href="/css/reset.css" />
      <link rel="stylesheet" href="/css/style.css" />

      <link rel="manifest" href="site.webmanifest" />
      <meta name="theme-color" content="#341a4e" />
      <meta name="color-scheme" content="dark" />
    </head>
    <body>
      <header>
        <div id="header-content">
          <a id="logo" href="/">Ezra's Site</a>

          <img src="/img/bird.svg" alt="" />

          <nav aria-label="primary">
            <ul>
              <li><a href="/blog">Blog</a></li>
              <li><a href="https://github.com/elazar125">Code</a></li>
            </ul>
          </nav>
        </div>
      </header>

      <main>
        <aside>
          <p>This is an RSS feed, you can use this to follow me without any algorithms deciding what you see.</p>
          <p>To use this you need an RSS Feed Reader. In the past I've used <a href="https://feedly.com/">Feedly</a>, it's good, free and easy to set up. These days I use <a href="https://miniflux.app/">Miniflux</a> so I can have full control over my data.</p>
          <p>Visit <a href="https://aboutfeeds.com">About Feeds</a> to learn more and get started!</p>
        </aside>
        <h1>Recent blog posts</h1>
        <ul class="card-list">
          <xsl:for-each select="/atom:feed/atom:entry">
            <li>
              <a class="card">
                <xsl:attribute name="href">
                  <xsl:value-of select="atom:link/@href"/>
                </xsl:attribute>
                <xsl:value-of select="atom:title"/>
                Last updated:
                <xsl:value-of select="substring(atom:updated, 0, 11)" />
              </a>
            </li>
          </xsl:for-each>
        </ul>
      </main>
    </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
