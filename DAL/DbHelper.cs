using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ProManage.DAL
{
    public class DbHelper
    {
        public static SqlConnection GetConnection()
        {
            // This reads the connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["ProManageDB"].ConnectionString;
            return new SqlConnection(connectionString);
        }
    }
}