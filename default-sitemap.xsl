<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet
	version="2.0"
	xmlns:html="http://www.w3.org/TR/html40"
	xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
	xmlns:image="http://www.google.com/schemas/sitemap-image/1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>

	<xsl:template match="/">
		<xsl:variable name="fileType">
			<xsl:choose>
				<xsl:when test="//channel">RSS</xsl:when>
				<xsl:when test="//sitemap:url">Sitemap</xsl:when>
				<xsl:otherwise>SitemapIndex</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>
					<xsl:choose>
						<xsl:when test="$fileType='Sitemap' or $fileType='RSS'">do sitemap</xsl:when>
						<xsl:otherwise>Índice do sitemap</xsl:otherwise>
					</xsl:choose>
				</title>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<style type="text/css">
	body {
		margin: 0;
		font-family: Helvetica, Arial, sans-serif;
		font-size: 68.5%;
	}
	#content-head {
		background-color: #141B38;
		padding: 20px 40px;
	}
	#content-head h1,
	#content-head p,
	#content-head a {
		color: #fff;
		font-size: 1.2em;
	}
	#content-head h1 {
		font-size: 2em;
	}
	table {
		margin: 20px 40px;
		border: none;
		border-collapse: collapse;
		font-size: 1em;
		width: 75%;
	}
	th {
		border-bottom: 1px solid #ccc;
		text-align: left;
		padding: 15px 5px;
		font-size: 14px;
	}
	td {
		padding: 10px 5px;
		border-left: 3px solid #fff;
	}
	tr.stripe {
		background-color: #f7f7f7;
	}
	table td a:not(.localized) {
		display: block;
	}
	table td a img {
		max-height: 30px;
		margin: 6px 3px;
	}
	.empty-sitemap {
		margin: 20px 40px;
		width: 75%;
	}
	.empty-sitemap__title {
		font-size: 18px;
		line-height: 125%;
		margin: 12px 0;
	}
	.empty-sitemap svg {
		width: 140px;
		height: 140px;
	}
	.empty-sitemap__buttons {
		margin-bottom: 30px;
	}
	.empty-sitemap__buttons .button {
		margin-right: 5px;
	}
	.breadcrumb {
		margin: 20px 40px;
		width: 75%;

		display: flex;
		align-items: center;
		font-size: 12px;
		font-weight: 600;
	}
	.breadcrumb a {
		color: #141B38;
		text-decoration: none;
	}
	.breadcrumb svg {
		margin: 0 10px;
	}
	@media (max-width: 1023px) {
		.breadcrumb svg:not(.back),
		.breadcrumb a:not(:last-of-type),
		.breadcrumb span {
			display: none;
		}
		.breadcrumb a:last-of-type::before {
			content: 'Voltar'
		}
	}
	@media (min-width: 1024px) {
		.breadcrumb {
			font-size: 14px;
		}
		.breadcrumb a {
			font-weight: 400;
		}
		.breadcrumb svg.back {
			display: none;
		}
	}
</style>
			</head>
			<body>
				<xsl:variable name="amountOfURLs">
					<xsl:choose>
						<xsl:when test="$fileType='RSS'">
							<xsl:value-of select="count(//channel/item)"></xsl:value-of>
						</xsl:when>
						<xsl:when test="$fileType='Sitemap'">
							<xsl:value-of select="count(sitemap:urlset/sitemap:url)"></xsl:value-of>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(sitemap:sitemapindex/sitemap:sitemap)"></xsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:call-template name="Header">
					<xsl:with-param name="title">do sitemap</xsl:with-param>
					<xsl:with-param name="amountOfURLs" select="$amountOfURLs"/>
					<xsl:with-param name="fileType" select="$fileType"/>
				</xsl:call-template>

				<div class="content">
					<div class="container">
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 0"><xsl:call-template name="emptySitemap"/></xsl:when>
							<xsl:when test="$fileType='Sitemap'"><xsl:call-template name="sitemapTable"/></xsl:when>
							<xsl:when test="$fileType='RSS'"><xsl:call-template name="sitemapRSS"/></xsl:when>
							<xsl:otherwise><xsl:call-template name="siteindexTable"/></xsl:otherwise>
						</xsl:choose>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="siteindexTable">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://pachinkogratis.net"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Índice do sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
				<tr>
					<th class="left">
						URL					</th>
					<th>Quantidade de URLs</th>
					<th>
						Última atualização					</th>
				</tr>
				</thead>
				<tbody>
				<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
				<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
				<xsl:for-each select="sitemap:sitemapindex/sitemap:sitemap">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>
						<td class="left">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="sitemap:loc" />
								</xsl:attribute>
								<xsl:value-of select="sitemap:loc"/>
							</a>
						</td>
						<td>
													</td>
						<td class="datetime">
							<div class="date">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-reloadbet/'">August 28, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-slottojam/'">August 28, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-betwinner/'">August 28, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/bugs-party/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade-2/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/superbola/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-advance/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/zombie-queen/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/halloween-jack/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/'">September 16, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-de-100-ate-r1000-na-vbet/'">August 14, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vbet/'">August 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/lucky-halloween/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wheely-wheely-big-win/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-fortunes/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-riches/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-extreme/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/pachinko/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/calavera-bingo/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tomatina-bingo/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/amazonia-fantasy/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/viking-runecraft-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vera-john/'">August 6, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/queen-of-gold-scratch/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-do-mundo-apostas-no-pachinko/'">August 6, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/rainforest-magic-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/sweet-alchemy-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-100-ate-700-brl-na-betwinner-com-pachinko/'">September 2, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/keno-80/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/flying-pigs/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/7-piggies-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/panda-gold-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-carnival/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/ante-up/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/baking-bonanza/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/big-wheel-slingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-berserk/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-britains-got-talent/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-centurion/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/the-price-is-right/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tutans-treasure/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/promocao-de-bonus-de-deposito-do-bc-game/'">August 1, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-mundo-apostas/'">August 5, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-bc-game/'">August 5, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/como-escolher-o-melhor-site-online-de-cassinos-no-brasil/'">May 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/shangri-la-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/cassinos-online-o-que-jogar/'">May 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/3-dicas-imperdiveis-para-jogar-cassino-online/'">May 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wild-run-scratch/'">August 12, 2024</xsl:when>
			</xsl:choose>
</div>
<div class="time">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-reloadbet/'">6:30 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-slottojam/'">6:13 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-betwinner/'">5:46 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/bugs-party/'">7:32 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade-2/'">7:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/superbola/'">7:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-advance/'">6:55 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/zombie-queen/'">7:02 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/halloween-jack/'">6:39 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/'">6:50 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-de-100-ate-r1000-na-vbet/'">2:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vbet/'">5:00 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/lucky-halloween/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wheely-wheely-big-win/'">5:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-fortunes/'">4:17 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade/'">4:17 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-riches/'">4:05 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-extreme/'">4:03 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/pachinko/'">4:01 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/calavera-bingo/'">3:59 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tomatina-bingo/'">3:58 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/amazonia-fantasy/'">3:57 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/viking-runecraft-bingo/'">6:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vera-john/'">4:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/queen-of-gold-scratch/'">6:48 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-do-mundo-apostas-no-pachinko/'">12:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/rainforest-magic-bingo/'">6:47 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/sweet-alchemy-bingo/'">6:43 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-100-ate-700-brl-na-betwinner-com-pachinko/'">9:40 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/keno-80/'">3:52 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/flying-pigs/'">1:55 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/7-piggies-scratch/'">1:46 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/panda-gold-scratch/'">1:31 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-carnival/'">6:21 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/ante-up/'">6:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/baking-bonanza/'">6:12 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/big-wheel-slingo/'">6:08 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-berserk/'">6:02 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-britains-got-talent/'">5:43 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-centurion/'">5:35 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/the-price-is-right/'">5:31 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tutans-treasure/'">5:30 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/promocao-de-bonus-de-deposito-do-bc-game/'">3:01 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-mundo-apostas/'">5:29 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-bc-game/'">5:21 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/como-escolher-o-melhor-site-online-de-cassinos-no-brasil/'">8:26 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/shangri-la-scratch/'">3:50 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/cassinos-online-o-que-jogar/'">7:44 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/3-dicas-imperdiveis-para-jogar-cassino-online/'">7:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wild-run-scratch/'">3:47 pm</xsl:when>
			</xsl:choose>
</div>						</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="sitemapRSS">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://pachinkogratis.net"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>do sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
					<tr>
						<th class="left">URL</th>
						<th>
							Data de publicação						</th>
					</tr>
				</thead>
				<tbody>
				<xsl:for-each select="//channel/item">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>
						<td class="left">
							<a>
								<xsl:attribute name="href">
									<xsl:value-of select="link" />
								</xsl:attribute>
								<xsl:value-of select="link"/>
							</a>
						</td>
						<td class="datetime">
							<div class="date">
	<xsl:choose>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-reloadbet/'">August 28, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-slottojam/'">August 28, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-betwinner/'">August 28, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/bugs-party/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-cascade-2/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/superbola/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-advance/'">August 20, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/zombie-queen/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/halloween-jack/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/'">September 16, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-de-100-ate-r1000-na-vbet/'">August 14, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-vbet/'">August 13, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/lucky-halloween/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/wheely-wheely-big-win/'">August 19, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-fortunes/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-cascade/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-riches/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-extreme/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/pachinko/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/calavera-bingo/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/tomatina-bingo/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/amazonia-fantasy/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/viking-runecraft-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-vera-john/'">August 6, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/queen-of-gold-scratch/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-do-mundo-apostas-no-pachinko/'">August 6, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/rainforest-magic-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/sweet-alchemy-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/bonus-de-100-ate-700-brl-na-betwinner-com-pachinko/'">September 2, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/keno-80/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/flying-pigs/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/7-piggies-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/panda-gold-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-carnival/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/ante-up/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/baking-bonanza/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/big-wheel-slingo/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-berserk/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-britains-got-talent/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-centurion/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/the-price-is-right/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/tutans-treasure/'">August 8, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/promocao-de-bonus-de-deposito-do-bc-game/'">August 1, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-mundo-apostas/'">August 5, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-bc-game/'">August 5, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/novidades/como-escolher-o-melhor-site-online-de-cassinos-no-brasil/'">May 13, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/shangri-la-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/novidades/cassinos-online-o-que-jogar/'">May 13, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/novidades/3-dicas-imperdiveis-para-jogar-cassino-online/'">May 13, 2024</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/wild-run-scratch/'">August 12, 2024</xsl:when>
			</xsl:choose>
</div>
<div class="time">
	<xsl:choose>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-reloadbet/'">6:30 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-slottojam/'">6:13 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-betwinner/'">5:46 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/bugs-party/'">7:32 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-cascade-2/'">7:19 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/superbola/'">7:10 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-advance/'">6:55 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/zombie-queen/'">7:02 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/halloween-jack/'">6:39 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/'">6:50 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-de-100-ate-r1000-na-vbet/'">2:24 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-vbet/'">5:00 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/lucky-halloween/'">6:38 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/wheely-wheely-big-win/'">5:10 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-fortunes/'">4:17 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-cascade/'">4:17 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-riches/'">4:05 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-extreme/'">4:03 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/pachinko/'">4:01 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/calavera-bingo/'">3:59 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/tomatina-bingo/'">3:58 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/amazonia-fantasy/'">3:57 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/viking-runecraft-bingo/'">6:24 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-vera-john/'">4:19 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/queen-of-gold-scratch/'">6:48 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-do-mundo-apostas-no-pachinko/'">12:10 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/rainforest-magic-bingo/'">6:47 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/sweet-alchemy-bingo/'">6:43 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/bonus-de-100-ate-700-brl-na-betwinner-com-pachinko/'">9:40 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/keno-80/'">3:52 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/flying-pigs/'">1:55 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/7-piggies-scratch/'">1:46 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/panda-gold-scratch/'">1:31 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-carnival/'">6:21 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/ante-up/'">6:19 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/baking-bonanza/'">6:12 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/big-wheel-slingo/'">6:08 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-berserk/'">6:02 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-britains-got-talent/'">5:43 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/slingo-centurion/'">5:35 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/the-price-is-right/'">5:31 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/tutans-treasure/'">5:30 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/promocoes/promocao-de-bonus-de-deposito-do-bc-game/'">3:01 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-mundo-apostas/'">5:29 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/casino/analise-do-casino-bc-game/'">5:21 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/novidades/como-escolher-o-melhor-site-online-de-cassinos-no-brasil/'">8:26 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/shangri-la-scratch/'">3:50 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/novidades/cassinos-online-o-que-jogar/'">7:44 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/novidades/3-dicas-imperdiveis-para-jogar-cassino-online/'">7:24 pm</xsl:when>
					<xsl:when test="link = 'https://pachinkogratis.net/jogos/wild-run-scratch/'">3:47 pm</xsl:when>
			</xsl:choose>
</div>						</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>

	<xsl:template name="sitemapTable">
		<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://pachinkogratis.net"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<a href="https://pachinkogratis.net/sitemap.xml"><span>Índice do sitemap</span></a>
						<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>do sitemap</span>
				</div>		<div class="table-wrapper">
			<table cellpadding="3">
				<thead>
					<tr>
						<th class="left">
							URL						</th>
													<th>
								Imagens							</th>
												<th>
							Frequência de alteração						</th>
						<th>
							Prioridade						</th>
						<th>
							Última atualização						</th>
					</tr>
				</thead>
				<tbody>
				<xsl:variable name="lower" select="'abcdefghijklmnopqrstuvwxyz'"/>
				<xsl:variable name="upper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
				<xsl:for-each select="sitemap:urlset/sitemap:url">
										<tr>
						<xsl:if test="position() mod 2 != 0">
							<xsl:attribute name="class">stripe</xsl:attribute>
						</xsl:if>

						<td class="left">
							<xsl:variable name="itemURL">
								<xsl:value-of select="sitemap:loc"/>
							</xsl:variable>

							<xsl:choose>
								<xsl:when test="count(./*[@rel='alternate']) > 0">
									<xsl:for-each select="./*[@rel='alternate']">
										<xsl:if test="position() = last()">
											<a href="{current()/@href}" class="localized">
												<xsl:value-of select="@href"/>
											</a> &#160;&#8594; <xsl:value-of select="@hreflang"/>
										</xsl:if>
									</xsl:for-each>
								</xsl:when>
								<xsl:otherwise>
									<a href="{$itemURL}">
										<xsl:value-of select="sitemap:loc"/>
									</a>
								</xsl:otherwise>
							</xsl:choose>

							<xsl:for-each select="./*[@rel='alternate']">
								<br />
								<xsl:if test="position() != last()">
									<a href="{current()/@href}" class="localized">
										<xsl:value-of select="@href"/>
									</a> &#160;&#8594; <xsl:value-of select="@hreflang"/>
								</xsl:if>
							</xsl:for-each>
						</td>
												<td>
							<div class="item-count">
								<xsl:value-of select="count(image:image)"/>
							</div>
						</td>
												<td>
							<xsl:value-of select="concat(translate(substring(sitemap:changefreq, 1, 1),concat($lower, $upper),concat($upper, $lower)),substring(sitemap:changefreq, 2))"/>
						</td>
						<td>
							<xsl:if test="string(number(sitemap:priority))!='NaN'">
								<xsl:call-template name="formatPriority">
									<xsl:with-param name="priority" select="sitemap:priority"/>
								</xsl:call-template>
							</xsl:if>
						</td>
						<td class="datetime">
							<div class="date">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-reloadbet/'">August 28, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-slottojam/'">August 28, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-betwinner/'">August 28, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/bugs-party/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade-2/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/superbola/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-advance/'">August 20, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/zombie-queen/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/halloween-jack/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/'">September 16, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-de-100-ate-r1000-na-vbet/'">August 14, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vbet/'">August 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/lucky-halloween/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wheely-wheely-big-win/'">August 19, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-fortunes/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-riches/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-extreme/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/pachinko/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/calavera-bingo/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tomatina-bingo/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/amazonia-fantasy/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/viking-runecraft-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vera-john/'">August 6, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/queen-of-gold-scratch/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-do-mundo-apostas-no-pachinko/'">August 6, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/rainforest-magic-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/sweet-alchemy-bingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-100-ate-700-brl-na-betwinner-com-pachinko/'">September 2, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/keno-80/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/flying-pigs/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/7-piggies-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/panda-gold-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-carnival/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/ante-up/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/baking-bonanza/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/big-wheel-slingo/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-berserk/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-britains-got-talent/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-centurion/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/the-price-is-right/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tutans-treasure/'">August 8, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/promocao-de-bonus-de-deposito-do-bc-game/'">August 1, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-mundo-apostas/'">August 5, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-bc-game/'">August 5, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/como-escolher-o-melhor-site-online-de-cassinos-no-brasil/'">May 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/shangri-la-scratch/'">August 12, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/cassinos-online-o-que-jogar/'">May 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/3-dicas-imperdiveis-para-jogar-cassino-online/'">May 13, 2024</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wild-run-scratch/'">August 12, 2024</xsl:when>
			</xsl:choose>
</div>
<div class="time">
	<xsl:choose>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-reloadbet/'">6:30 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-slottojam/'">6:13 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-betwinner/'">5:46 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/bugs-party/'">7:32 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade-2/'">7:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/superbola/'">7:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-advance/'">6:55 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/zombie-queen/'">7:02 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/halloween-jack/'">6:39 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/'">6:50 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-de-100-ate-r1000-na-vbet/'">2:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vbet/'">5:00 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/lucky-halloween/'">6:38 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wheely-wheely-big-win/'">5:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-fortunes/'">4:17 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-cascade/'">4:17 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-riches/'">4:05 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-extreme/'">4:03 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/pachinko/'">4:01 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/calavera-bingo/'">3:59 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tomatina-bingo/'">3:58 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/amazonia-fantasy/'">3:57 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/viking-runecraft-bingo/'">6:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-vera-john/'">4:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/queen-of-gold-scratch/'">6:48 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-boas-vindas-do-mundo-apostas-no-pachinko/'">12:10 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/rainforest-magic-bingo/'">6:47 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/sweet-alchemy-bingo/'">6:43 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/bonus-de-100-ate-700-brl-na-betwinner-com-pachinko/'">9:40 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/keno-80/'">3:52 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/flying-pigs/'">1:55 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/7-piggies-scratch/'">1:46 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/panda-gold-scratch/'">1:31 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-carnival/'">6:21 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/ante-up/'">6:19 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/baking-bonanza/'">6:12 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/big-wheel-slingo/'">6:08 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-berserk/'">6:02 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-britains-got-talent/'">5:43 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/slingo-centurion/'">5:35 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/the-price-is-right/'">5:31 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/tutans-treasure/'">5:30 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/promocoes/promocao-de-bonus-de-deposito-do-bc-game/'">3:01 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-mundo-apostas/'">5:29 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/casino/analise-do-casino-bc-game/'">5:21 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/como-escolher-o-melhor-site-online-de-cassinos-no-brasil/'">8:26 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/shangri-la-scratch/'">3:50 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/cassinos-online-o-que-jogar/'">7:44 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/novidades/3-dicas-imperdiveis-para-jogar-cassino-online/'">7:24 pm</xsl:when>
					<xsl:when test="sitemap:loc = 'https://pachinkogratis.net/jogos/wild-run-scratch/'">3:47 pm</xsl:when>
			</xsl:choose>
</div>						</td>
					</tr>
				</xsl:for-each>
				</tbody>
			</table>
		</div>
			</xsl:template>

	<xsl:template name="Header">
	<xsl:param name="title"/>
	<xsl:param name="amountOfURLs"/>
	<xsl:param name="fileType"/>

	<div id="content-head">
		<h1><xsl:value-of select="$title"/></h1>
		<xsl:choose>
			<xsl:when test="$fileType='RSS'">
				<p>Gerado por <a href="https://aioseo.com/?utm_source=WordPress&#038;utm_campaign=liteplugin&#038;utm_medium=rss-sitemap" target="_blank" rel="noreferrer noopener">All in One SEO</a>, este é um Sitemap RSS, destinado a ser consumido por mecanismos de pesquisa como Google ou Bing.</p>
				<p>
					Você pode encontrar mais informações sobre Sitemaps RSS em <a href="https://www.sitemaps.org/" target="_blank" rel="noreferrer noopener">sitemaps.org</a>.				</p>
			</xsl:when>
			<xsl:otherwise>
				<p>Gerado por <a href="https://aioseo.com/?utm_source=WordPress&#038;utm_campaign=liteplugin&#038;utm_medium=rss-sitemap" target="_blank" rel="noreferrer noopener">All in One SEO</a>, este é um sitemap em XML, destinado a ser consumido por mecanismos de pesquisa como Google ou Bing.</p>
				<p>
					Você pode encontrar mais informações sobre sitemaps em XML em <a href="https://www.sitemaps.org/" target="_blank" rel="noreferrer noopener">sitemaps.org</a>.				</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$amountOfURLs &gt; 0">
			<p>
				<xsl:choose>
					<xsl:when test="$fileType='Sitemap' or $fileType='RSS'">
						Este sitemap contém						<xsl:value-of select="$amountOfURLs"/>
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 1">
								URL							</xsl:when>
							<xsl:otherwise>
								URLs							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						Este índice de sitemap contém						<xsl:value-of select="$amountOfURLs"/>
						<xsl:choose>
							<xsl:when test="$amountOfURLs = 1">
								sitemap							</xsl:when>
							<xsl:otherwise>
								sitemaps							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
				e foi gerado em novembro 5, 2025 às 11:22 pm			</p>
		</xsl:if>
	</div>
</xsl:template>
	<xsl:template name="formatPriority">
	<xsl:param name="priority"/>

	<xsl:variable name="priorityLevel">
		<xsl:choose>
			<xsl:when test="$priority &lt;= 0.5">low</xsl:when>
			<xsl:when test="$priority &gt;= 0.6 and $priority &lt;= 0.8">medium</xsl:when>
			<xsl:when test="$priority &gt;= 0.9">high</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<xsl:variable name="priorityLabel">
		<xsl:choose>
			<xsl:when test="$priorityLevel = 'low'">Baixa</xsl:when>
			<xsl:when test="$priorityLevel = 'medium'">Médio</xsl:when>
			<xsl:when test="$priorityLevel = 'high'">Alta</xsl:when>
		</xsl:choose>
	</xsl:variable>

	<div>
		<xsl:attribute name="class">
			<xsl:value-of select="concat('priority priority--', $priorityLevel)" />
		</xsl:attribute>
		<xsl:value-of select="$priorityLabel" />
	</div>
</xsl:template>
	<xsl:template name="emptySitemap">
	<div class="breadcrumb">
	<svg class="back" width="6" height="9" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.274 7.56L2.22 4.5l3.054-3.06-.94-.94-4 4 4 4 .94-.94z" fill="#141B38"/></svg>

	<a href="https://pachinkogratis.net"><span>Início</span></a>

			<svg width="6" height="8" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M.727 7.06L3.78 4 .727.94l.94-.94 4 4-4 4-.94-.94z" fill="#141B38"/></svg>

					<span>Índice do sitemap</span>
				</div>	<div class="empty-sitemap">
		<h2 class="empty-sitemap__title">
			Algo deu errado!			<br />
			Não há nenhum post aqui		</h2>
		<div class="empty-sitemap__buttons">
			<a href="https://pachinkogratis.net" class="button">Voltar à página inicial</a>
					</div>

			</div>
	<style>
		.hand-magnifier{
			animation: hand-magnifier .8s infinite ease-in-out;
			transform-origin: center 90%;
			transform-box: fill-box;
		}
		@keyframes hand-magnifier {
			0% {
				transform: rotate(0deg);
			}
			50% {
				transform: rotate(-12deg);
			}
			100% {
				transform: rotate(0deg);
			}
		}
	</style>
</xsl:template>
</xsl:stylesheet>
<!-- permalink_structure ends with slash (/) but REQUEST_URI does not end with slash (/) -->