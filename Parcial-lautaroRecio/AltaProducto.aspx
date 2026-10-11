<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AltaProducto.aspx.cs" Inherits="Parcial_lautaroRecio.AltaProducto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Alta de productos</title>
    <link href="Content/tienda.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="encabezado">
            <h1>GameZone</h1>
            <p>Tienda online de videojuegos</p>
        </div>
        <div class="contenedor">
            <h2>Alta de productos</h2>

            <div class="campo">
                <span class="etiqueta">Nombre:</span>
                <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" placeholder="Nombre del producto"></asp:TextBox>
            </div>
            <div class="campo">
                <span class="etiqueta">Precio:</span>
                <asp:TextBox ID="txtPrecio" runat="server" placeholder="Precio (ej: 59999,99)"></asp:TextBox>
            </div>
            <div class="campo">
                <span class="etiqueta">Categoría:</span>
                <asp:DropDownList ID="ddlCategoria" runat="server" DataSourceID="sqlCategorias"
                    DataTextField="descripcion" DataValueField="idCategoria">
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar" CssClass="boton" OnClick="btnConfirmar_Click" />
            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            <asp:SqlDataSource ID="sqlCategorias" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select idCategoria, descripcion from categorias order by descripcion">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlAltaProducto" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                InsertCommand="insert into productos(nombre, precio, idCategoria) values (@nombre, @precio, @idCategoria)">
                <InsertParameters>
                    <asp:Parameter Name="nombre" Type="String" />
                    <asp:Parameter Name="precio" Type="Decimal" />
                    <asp:Parameter Name="idCategoria" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>

            <br />
            <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Default.aspx" CssClass="volver">&larr; Volver a la página principal</asp:HyperLink>
        </div>
    </form>
</body>
</html>
