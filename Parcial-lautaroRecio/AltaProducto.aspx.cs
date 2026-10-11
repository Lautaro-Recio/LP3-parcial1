using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial_lautaroRecio
{
    public partial class AltaProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnConfirmar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtPrecio.Text))
            {
                lblMensaje.Text = "Complete el nombre y el precio.";
                lblMensaje.CssClass = "mensaje error";
                return;
            }

            try
            {
                this.sqlAltaProducto.InsertParameters["nombre"].DefaultValue = this.txtNombre.Text;
                this.sqlAltaProducto.InsertParameters["precio"].DefaultValue = this.txtPrecio.Text;
                this.sqlAltaProducto.InsertParameters["idCategoria"].DefaultValue = this.ddlCategoria.SelectedValue;
                this.sqlAltaProducto.Insert();

                lblMensaje.Text = "Se efectuó la carga del producto.";
                lblMensaje.CssClass = "mensaje ok";
                this.txtNombre.Text = "";
                this.txtPrecio.Text = "";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error: " + ex.Message;
                lblMensaje.CssClass = "mensaje error";
            }
        }
    }
}
