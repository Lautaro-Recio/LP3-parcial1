<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModificacionProducto.aspx.cs" Inherits="Parcial_lautaroRecio.ModificacionProducto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Modificación de productos</title>
    <link href="Content/tienda.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="encabezado">
            <h1>GameZone</h1>
            <p>Tienda online de videojuegos</p>
        </div>
        <div class="contenedor">
            <h2>Modificación de productos</h2>

            <div class="campo">
                <span class="etiqueta">Buscar por:</span>
                <asp:RadioButton ID="rbCodigo" runat="server" GroupName="tipoBusqueda" Text="Código" Checked="True" CssClass="opcion" />
                <asp:RadioButton ID="rbNombre" runat="server" GroupName="tipoBusqueda" Text="Nombre" CssClass="opcion" />
            </div>
            <div class="campo">
                <span class="etiqueta">Producto a modificar:</span>
                <asp:TextBox ID="txtBuscar" runat="server" placeholder="Código o nombre del producto"></asp:TextBox>
            </div>
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar producto" CssClass="boton" OnClick="btnBuscar_Click" />

            <asp:Panel ID="pnlEdicion" runat="server" Visible="False">
                <hr />
                <div class="campo">
                    <span class="etiqueta">Nombre:</span>
                    <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" placeholder="Nuevo nombre"></asp:TextBox>
                </div>
                <div class="campo">
                    <span class="etiqueta">Precio:</span>
                    <asp:TextBox ID="txtPrecio" runat="server" placeholder="Nuevo precio (ej: 59999,99)"></asp:TextBox>
                </div>
                <div class="campo">
                    <span class="etiqueta">Categoría:</span>
                    <asp:DropDownList ID="ddlCategoria" runat="server" DataSourceID="sqlCategorias"
                        DataTextField="descripcion" DataValueField="idCategoria">
                    </asp:DropDownList>
                </div>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios" CssClass="boton" OnClick="btnGuardar_Click" />
            </asp:Panel>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje"></asp:Label>

            <asp:SqlDataSource ID="sqlCategorias" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select idCategoria, descripcion from categorias order by descripcion">
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlBuscarPorCodigo" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select idProducto, nombre, precio, idCategoria from productos where idProducto = @idProducto">
                <SelectParameters>
                    <asp:Parameter Name="idProducto" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlBuscarPorNombre" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                SelectCommand="select idProducto, nombre, precio, idCategoria from productos where nombre like '%' + @nombre + '%'">
                <SelectParameters>
                    <asp:Parameter Name="nombre" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlModificarProducto" runat="server"
                ConnectionString="<%$ ConnectionStrings:TiendaConnection %>"
                UpdateCommand="update productos set nombre = @nombre, precio = @precio, idCategoria = @idCategoria where idProducto = @idProducto">
                <UpdateParameters>
                    <asp:Parameter Name="nombre" Type="String" />
                    <asp:Parameter Name="precio" Type="Decimal" />
                    <asp:Parameter Name="idCategoria" Type="Int32" />
                    <asp:Parameter Name="idProducto" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>

            <br />
            <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Default.aspx" CssClass="volver">&larr; Volver a la página principal</asp:HyperLink>
        </div>
    </form>
</body>
</html>
