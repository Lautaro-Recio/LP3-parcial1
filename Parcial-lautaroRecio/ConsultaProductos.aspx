<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ConsultaProductos.aspx.cs" Inherits="Parcial_lautaroRecio.ConsultaProductos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Consulta de productos</title>
    <link href="Content/tienda.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="encabezado">
            <h1>GameZone</h1>
            <p>Tienda online de videojuegos</p>
        </div>
        <div class="contenedor">
            <h2>Consulta de productos</h2>

            <div class="campo">
                <span class="etiqueta">Filtrar por categoría:</span>
                <asp:DropDownList ID="ddlFiltroCategoria" runat="server" AutoPostBack="True" AppendDataBoundItems="True"
                    DataSourceID="sqlCategorias" DataTextField="descripcion" DataValueField="idCategoria">
                    <asp:ListItem Value="0">Todas</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" CssClass="grilla"
                DataSourceID="sqlConsultaProductos" DataKeyNames="idProducto" GridLines="None"
                EmptyDataText="No hay productos cargados.">
                <Columns>
                    <asp:BoundField DataField="idProducto" HeaderText="Código" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="precio" HeaderText="Precio" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="categoria" HeaderText="Categoría" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="sqlCategorias" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select idCategoria, descripcion from categorias order by descripcion">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlConsultaProductos" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select p.idProducto, p.nombre, p.precio, c.descripcion as categoria
                               from productos as p
                               join categorias as c on c.idCategoria = p.idCategoria
                               where @idCategoria = 0 or p.idCategoria = @idCategoria
                               order by p.idProducto">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlFiltroCategoria" Name="idCategoria" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Default.aspx" CssClass="volver">&larr; Volver a la página principal</asp:HyperLink>
        </div>
    </form>
</body>
</html>
