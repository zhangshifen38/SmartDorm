package com.app.dormsys;

import com.app.dormsys.tools.MD5;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DormSysApplicationTests {

    @Test
    void contextLoads() {
        System.out.println(MD5.MD5EncodeUtf8("123456"));
    }

}
