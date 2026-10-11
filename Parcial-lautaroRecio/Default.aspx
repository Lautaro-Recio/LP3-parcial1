<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Parcial_lautaroRecio._Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>GameZone - Tienda de Videojuegos</title>
    <link href="Content/tienda.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="encabezado">
            <h1>GameZone</h1>
            <p>Tienda online de videojuegos</p>
        </div>
        <div class="contenedor">
            <h2>Administración de productos</h2>
            <div class="menu">
                <asp:HyperLink ID="hlAltaProducto" runat="server" Text="Alta de productos" NavigateUrl="~/AltaProducto.aspx"></asp:HyperLink>
                <asp:HyperLink ID="hlBajaProducto" runat="server" Text="Baja de productos" NavigateUrl="~/BajaProducto.aspx"></asp:HyperLink>
                <asp:HyperLink ID="hlModificacionProducto" runat="server" Text="Modificación de productos" NavigateUrl="~/ModificacionProducto.aspx"></asp:HyperLink>
                <asp:HyperLink ID="hlConsultaProductos" runat="server" Text="Consulta de productos" NavigateUrl="~/ConsultaProductos.aspx"></asp:HyperLink>
            </div>
        </div>
    </form>
</body>
</html>
