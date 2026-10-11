<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BajaProducto.aspx.cs" Inherits="Parcial_lautaroRecio.BajaProducto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Baja de productos</title>
    <link href="Content/tienda.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="encabezado">
            <h1>GameZone</h1>
            <p>Tienda online de videojuegos</p>
        </div>
        <div class="contenedor">
            <h2>Baja de productos</h2>
            <p>Marque los productos que desea eliminar.</p>

            <asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" CssClass="grilla"
                DataSourceID="sqlProductos" DataKeyNames="idProducto" GridLines="None"
                EmptyDataText="No hay productos cargados.">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSeleccionar" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="idProducto" HeaderText="Código" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="precio" HeaderText="Precio" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="categoria" HeaderText="Categoría" />
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar seleccionados" CssClass="boton boton-peligro"
                OnClick="btnEliminar_Click" />

            <asp:Panel ID="pnlConfirmar" runat="server" Visible="False" CssClass="confirmacion">
                <asp:Label ID="lblConfirmar" runat="server"></asp:Label>
                <br /><br />
                <asp:Button ID="btnSi" runat="server" Text="Sí, eliminar" CssClass="boton boton-peligro" OnClick="btnSi_Click" />
                <asp:Button ID="btnNo" runat="server" Text="Cancelar" CssClass="boton" OnClick="btnNo_Click" />
            </asp:Panel>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            <asp:SqlDataSource ID="sqlProductos" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select p.idProducto, p.nombre, p.precio, c.descripcion as categoria
                               from productos as p
                               join categorias as c on c.idCategoria = p.idCategoria
                               order by p.idProducto">
            </asp:SqlDataSource>

            <%-- Solo se borra de la tabla productos: la tabla categorias no se modifica --%>
            <asp:SqlDataSource ID="sqlEliminarProducto" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                DeleteCommand="delete from productos where idProducto = @idProducto">
                <DeleteParameters>
                    <asp:Parameter Name="idProducto" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <br />
            <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Default.aspx" CssClass="volver">&larr; Volver a la página principal</asp:HyperLink>
        </div>
    </form>
</body>
</html>
