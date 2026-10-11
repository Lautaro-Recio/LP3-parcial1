using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial_lautaroRecio
{
    public partial class BajaProducto : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string codigos = "";
            string nombres = "";

            foreach (GridViewRow fila in this.gvProductos.Rows)
            {
                CheckBox chkSeleccionar = (CheckBox)fila.FindControl("chkSeleccionar");
                if (chkSeleccionar.Checked)
                {
                    string codigo = this.gvProductos.DataKeys[fila.RowIndex].Value.ToString();
                    codigos = codigos + codigo + ",";
                    nombres = nombres + "<br />- " + fila.Cells[2].Text;
                }
            }

            if (codigos == "")
            {
                pnlConfirmar.Visible = false;
                lblMensaje.Text = "No seleccionó ningún producto.";
                lblMensaje.CssClass = "mensaje error";
                return;
            }

            ViewState["codigos"] = codigos;
            lblConfirmar.Text = "¿Está seguro de que desea eliminar estos productos?" + nombres;
            pnlConfirmar.Visible = true;
            lblMensaje.Text = "";
        }

        protected void btnSi_Click(object sender, EventArgs e)
        {
            int cant = 0;
            string[] codigos = ((string)ViewState["codigos"]).Split(',');

            foreach (string codigo in codigos)
            {
                if (codigo != "")
                {
                    this.sqlEliminarProducto.DeleteParameters["idProducto"].DefaultValue = codigo;
                    cant = cant + this.sqlEliminarProducto.Delete();
                }
            }

            pnlConfirmar.Visible = false;
            lblMensaje.Text = "Se eliminaron " + cant + " producto(s).";
            lblMensaje.CssClass = "mensaje ok";
            this.gvProductos.DataBind();
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            pnlConfirmar.Visible = false;
            lblMensaje.Text = "Se canceló la eliminación.";
            lblMensaje.CssClass = "mensaje error";
        }
    }
}
