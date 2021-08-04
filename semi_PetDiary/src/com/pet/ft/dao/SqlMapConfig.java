package com.pet.ft.dao;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class SqlMapConfig {

    private SqlSessionFactory sqlSessionFactory;

    public SqlSessionFactory getSqlSessionFactory() {
        String resources = "com/pet/ft/db/mybatis_config.xml";


        try {
            InputStream inputStream = Resources.getResourceAsStream(resources);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);

            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return sqlSessionFactory;
    }

}
