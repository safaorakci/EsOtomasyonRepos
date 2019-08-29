using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

public class SqlDataAccess
{
    public const string CONNECTION_STRING_NAME = "Baglantim";

    private static string _connectionString = string.Empty;
    public static string ConnectionString
    {
        get
        {
            if (_connectionString == string.Empty)
            {
                _connectionString = ConfigurationManager.ConnectionStrings[CONNECTION_STRING_NAME].ConnectionString;
            }
            return _connectionString;
        }
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="sql"></param>
    /// <returns></returns>
    public SqlCommand GetCommand(string sql)
    {
        SqlConnection conn = new SqlConnection(ConnectionString);
        SqlCommand sqlCmd = new SqlCommand(sql, conn);
        return sqlCmd;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sql"></param>
    /// <returns></returns>
    public DataTable Execute(string sql)
    {
        DataTable dt = new DataTable();
        SqlCommand cmd = GetCommand(sql);
        cmd.Connection.Open();
        dt.Load(cmd.ExecuteReader());
        cmd.Connection.Close();
        return dt;
    }

    internal DataTable Execute(object p)
    {
        throw new NotImplementedException();
    }

    /// <summary>
    /// Datatable Döndür
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    public DataTable Execute(SqlCommand command)
    {
        DataTable dt = new DataTable();
        command.Connection.Open();
        //command.ExecuteNonQuery();
        dt.Load(command.ExecuteReader());
        command.Connection.Close();
        return dt;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sql"></param>
    /// <returns></returns>
    public int ExecuteNonQuery(string sql)
    {
        SqlCommand cmd = GetCommand(sql);
        cmd.Connection.Open();
        int result = cmd.ExecuteNonQuery();
        cmd.Connection.Close();
        return result;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    public int ExecuteNonQuery(SqlCommand command)
    {
        command.Connection.Open();
        int result = command.ExecuteNonQuery();
        command.Connection.Close();
        return result;
    }


    /// <summary>
    /// 
    /// </summary>
    /// <param name="spName"></param>
    /// <returns></returns>
    public int ExecuteStoredProcedure(string spName)
    {
        SqlCommand cmd = GetCommand(spName);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Connection.Open();
        int result = cmd.ExecuteNonQuery();
        cmd.Connection.Close();
        return result;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="command"></param>
    /// <returns></returns>
    public int ExecuteStoredProcedure(SqlCommand command)
    {
        command.CommandType = CommandType.StoredProcedure;
        command.Connection.Open();
        int result = command.ExecuteNonQuery();
        command.Connection.Close();
        return result;
    }

}
