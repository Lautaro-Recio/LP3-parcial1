using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Parcial_lautaroRecio
{
    public partial class ModificacionProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Busca el producto y muestra sus datos actuales
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            pnlEdicion.Visible = false;

            // Verifica que el campo de texto no este vacio
            if (string.IsNullOrEmpty(txtBuscar.Text))
            {
                lblMensaje.Text = "Ingrese el código o el nombre del producto.";
                lblMensaje.CssClass = "mensaje error";
                return;
            }

            try
            {
                SqlDataReader registros;

                // Busca por codigo o por nombre segun la opcion elegida
                if (rbCodigo.Checked)
                {
                    this.sqlBuscarPorCodigo.SelectParameters["idProducto"].DefaultValue = this.txtBuscar.Text;
                    this.sqlBuscarPorCodigo.DataSourceMode = SqlDataSourceMode.DataReader;
                    registros = (SqlDataReader)this.sqlBuscarPorCodigo.Select(DataSourceSelectArguments.Empty);
                }
                else
                {
                    this.sqlBuscarPorNombre.SelectParameters["nombre"].DefaultValue = this.txtBuscar.Text;
                    this.sqlBuscarPorNombre.DataSourceMode = SqlDataSourceMode.DataReader;
                    registros = (SqlDataReader)this.sqlBuscarPorNombre.Select(DataSourceSelectArguments.Empty);
                }

                if (registros.Read())
                {
                    this.txtNombre.Text = registros["nombre"].ToString();
                    this.txtPrecio.Text = registros["precio"].ToString();
                    this.ddlCategoria.SelectedValue = registros["idCategoria"].ToString();

                    // Guarda los datos originales para saber despues si se modifico algo
                    ViewState["codigo"] = registros["idProducto"].ToString();
                    ViewState["nombre"] = this.txtNombre.Text;
                    ViewState["precio"] = this.txtPrecio.Text;
                    ViewState["categoria"] = registros["idCategoria"].ToString();

                    // Si hay otro registro, el nombre coincide con mas de un producto
                    if (registros.Read())
                    {
                        lblMensaje.Text = "Hay más de un producto con ese nombre. Escriba el nombre más completo o busque por código.";
                        lblMensaje.CssClass = "mensaje error";
                    }
                    else
                    {
                        pnlEdicion.Visible = true;
                        lblMensaje.Text = "";
                    }
                }
                else
                {
                    lblMensaje.Text = "No existe un producto con ese código o nombre.";
                    lblMensaje.CssClass = "mensaje error";
                }
                registros.Close();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.CssClass = "mensaje error";
            }
        }

        // Guarda los cambios del producto
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtPrecio.Text))
            {
                lblMensaje.Text = "El nombre y el precio no pueden quedar vacíos.";
                lblMensaje.CssClass = "mensaje error";
                return;
            }

            // Verifica que al menos un campo se haya modificado
            if (txtNombre.Text == (string)ViewState["nombre"] &&
                txtPrecio.Text == (string)ViewState["precio"] &&
                ddlCategoria.SelectedValue == (string)ViewState["categoria"])
            {
                lblMensaje.Text = "No se modificó ningún campo.";
                lblMensaje.CssClass = "mensaje error";
                return;
            }

            try
            {
                this.sqlModificarProducto.UpdateParameters["nombre"].DefaultValue = this.txtNombre.Text;
                this.sqlModificarProducto.UpdateParameters["precio"].DefaultValue = this.txtPrecio.Text;
                this.sqlModificarProducto.UpdateParameters["idCategoria"].DefaultValue = this.ddlCategoria.SelectedValue;
                this.sqlModificarProducto.UpdateParameters["idProducto"].DefaultValue = (string)ViewState["codigo"];
                int cant;
                cant = this.sqlModificarProducto.Update();
                if (cant == 1)
                {
                    lblMensaje.Text = "Se modificó el producto.";
                    lblMensaje.CssClass = "mensaje ok";
                    ViewState["nombre"] = this.txtNombre.Text;
                    ViewState["precio"] = this.txtPrecio.Text;
                    ViewState["categoria"] = this.ddlCategoria.SelectedValue;
                }
                else
                {
                    lblMensaje.Text = "No existe dicho código de producto.";
                    lblMensaje.CssClass = "mensaje error";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.CssClass = "mensaje error";
            }
        }
    }
}
