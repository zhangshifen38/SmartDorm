//import { IpPort } from "./ip";
const IpPort = 'http://localhost:8888';
// ************************************** 登录界面 ***********************************************

// 存储用户名和密码
function index_loading() {
    var User = sessionStorage.getItem("CounselorUserName");
    var text = document.getElementById("hello");
    text.innerHTML += User;
}

// 登录界面到主页的跳转 不同身份不同界面：
// 前端发送给后端的参数：用户名uno、密码upass、用户类型utype，
// 然后后端返回True和False，表示登录成功与否，
// 如果登录成功的话，前端需自行保存用户名uno、用户类型utype，以备后续使用；以上参数均为String类型
function func_login() {
    var choice = $("input[type='radio']:checked").val();
    // alert(choice);
    var User = document.getElementById("user").value;
    // alert(User);
    sessionStorage.clear(); // 删除原有数据
    sessionStorage.setItem("CounselorUserName", User);
    var Pass = document.getElementById("pass").value;
    var codePass = md5(Pass);
    sessionStorage.setItem("CounselorPassword", Pass);

    if (User != null && Pass != null && choice != null) {
		console.log(IpPort+'/login')
        axios.get(IpPort+'/login', {
            params: {
                uno: User,
                upass: codePass,
                utype: choice
            }
        })
            .then(function (response) {
                // 返回true，登陆成功
                console.log(response.data);

                if (response.data === true) {
                    window.close();
                    if (choice === "学生") {
                        window.open("./main.html");
                    }
                    else if (choice === "宿舍管理员") {
                        window.open("./hostel-main.html");
                    }
                    else if (choice === "辅导员") {
                        window.open("./Counsellor/index.html");
                    }
                    else {
                        alert("输入有误！");
                    }
                }
                else {
                    alert("登陆失败...")
                }
                response.end();

            })
            .catch(function (error) {
                console.log(error);
            });
        // alert("登陆成功！")
        // alert(sessionStorage.getItem("CounselorUserName"));
        // alert("等待结果")
    }
    else {
        alert("请输入完整信息！")
    }

}

// *********************************************个人信息界面**********************************

// 进入个人信息界面，页面加载时就显示信息
function person_info_loading() {
    // // 通过sno，获得sname、ssex、stel...
    getStuInfo();

    // // 获取退 / 换宿信息，并显示表单
    // // document.getElementById('name1').innerHTML = '值';
    getDormChangeInfo();
    getDormCheckoutInfo();
    getRepairInfo();
    getStuLeave();
}

function getStuLeave() {
    var User = sessionStorage.getItem("CounselorUserName");
    var reason;
    var edate; // 处理时间
    var leavedate; // 离开时间
    var backdate; // 回来时间
    var state; // 处理结果
    var res = document.getElementById("leave-table");
    axios.get(IpPort+'/getStuLeave', {
        params: {
            sno: User
        }
    })
        .then(function (response) {
            console.log(response.data);
            if (response.data === null) {

                var resHtml = `
                <tr class="active" >
                    <td>
                      无
                    </td>
                    <td>无</td>
                    <td>无</td>
                </tr>
                `;
                res.innerHTML += resHtml;
            }
            else {
                for (let i = 0; i < response.data.length; i++) {

                    // alert(response.data[i].checkoutdate);
                    // alert(date.toLocaleDateString());
                    reason = response.data[i].reason;
                    if (reason == "") {
                        reason = '无'
                    }
                    state = response.data[i].state;
                    console.log(state)
                    leavedate = response.data[i].leavedate.substr(0, 10);
                    backdate = response.data[i].backdate.substr(0, 10);
                    if (response.data[i].edate === null) {
                        edate = "未处理";
                    }
                    else {
                        edate = response.data[i].edate.substr(0, 10);
                    }

                    if (i % 5 == 0) {
                        var resHtml = `
                <tr class="active" >
                    <td>拟离校日期：`+ leavedate + `<br>
                    拟返校日期：`+ backdate + `<br>请假原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 1) {
                        var resHtml = `
                <tr class="success" >
                    <td>拟离校日期：`+ leavedate + `<br>
                    拟返校日期：`+ backdate + `<br>请假原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 2) {
                        var resHtml = `
                <tr class="info" >
                    <td>拟离校日期：`+ leavedate + `<br>
                    拟返校日期：`+ backdate + `<br>请假原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 3) {
                        var resHtml = `
                <tr class="warning" >
                    <td>拟离校日期：`+ leavedate + `<br>
                    拟返校日期：`+ backdate + `<br>请假原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 4) {
                        var resHtml = `
                <tr class="danger" >
                    <td>拟离校日期：`+ leavedate + `<br>
                    拟返校日期：`+ backdate + `<br>请假原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    res.innerHTML += resHtml;
                }
            }
        });
}

function getRepairInfo() {
    var User = sessionStorage.getItem("CounselorUserName");
    var reason;
    var itemname;
    var edate; // 处理时间
    var repairdate; // 预期时间
    var state; // 处理结果
    var res = document.getElementById("repair-table");
    axios.get(IpPort+'/getRepairstoStu', {
        params: {
            sno: User
        }
    })
        .then(function (response) {
            console.log(response.data);
            if (response.data === null) {

                var resHtml = `
                <tr class="active" >
                    <td>
                      无
                    </td>
                    <td>无</td>
                    <td>无</td>
                </tr>
                `;
                res.innerHTML += resHtml;
            }
            else {
                for (let i = 0; i < response.data.length; i++) {

                    // alert(response.data[i].checkoutdate);
                    // alert(date.toLocaleDateString());
                    repairdate = response.data[i].repairdate.substr(0, 10);
                    if (response.data[i].edate === null) {
                        edate = "未处理";
                    }
                    else {
                        edate = response.data[i].edate.substr(0, 10);
                    }
                    itemname = response.data[i].itemname;
                    reason = response.data[i].reason;
                    state = response.data[i].state;
                    if (i % 5 == 0) {
                        var resHtml = `
                <tr class="active" >
                    <td>报修物品：`+ itemname + `<br>
                    期望报修时间：`+ repairdate + `<br>报修原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 1) {
                        var resHtml = `
                <tr class="success" >
                    <td>报修物品：`+ itemname + `<br>
                    期望报修时间：`+ repairdate + `<br>报修原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 2) {
                        var resHtml = `
                <tr class="info" >
                    <td>报修物品：`+ itemname + `<br>
                    期望报修时间：`+ repairdate + `<br>报修原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 3) {
                        var resHtml = `
                <tr class="warning" >
                    <td>报修物品：`+ itemname + `<br>
                    期望报修时间：`+ repairdate + `<br>报修原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 4) {
                        var resHtml = `
                <tr class="danger" >
                    <td>报修物品：`+ itemname + `<br>
                    期望报修时间：`+ repairdate + `<br>报修原因：` + reason +
                            `</td>
                    <td>`+ edate + `</td>
                    <td>`+ state + `</td>
                </tr>
                `;
                    }
                    res.innerHTML += resHtml;
                }
            }
        });
}

function getStuInfo() {
    var User = sessionStorage.getItem("CounselorUserName");
    // alert(User);
    axios.get(IpPort+'/StudentUserInfo', {
        params: {
            sno: User
        }
    })
        .then(function (response) {
            // alert(response.data);
            // // $('#name1').val('值');
            // // 查学生表得到学生信息
            document.getElementById('stu-id').value = response.data.sno; // 学号
            document.getElementById('stu-name').value = response.data.sname; // 姓名
            document.getElementById('stu-sex').value = response.data.ssex; // 性别
            document.getElementById('stu-college').value = response.data.scol; // 院
            document.getElementById('stu-department').value = response.data.sdept; // 系
            document.getElementById('stu-class').value = response.data.sclass; // 班级
            sessionStorage.setItem("class", response.data.sclass);
            sessionStorage.setItem("tel", response.data.stel);
            document.getElementById('stu-phone').value = response.data.stel; // 电话
            document.getElementById('stu-bno').value = response.data.buildings_bno; // 楼栋号
            document.getElementById('stu-dno').value = response.data.dorms_dno; // 宿舍号
            document.getElementById('stu-status').value = response.data.state; // 在校状态
            document.getElementById('stu-access').value = response.data.access; // 门禁状态
        });
}

// 查退换宿表，得到换宿信息
function getDormChangeInfo() {
    var User = sessionStorage.getItem("CounselorUserName");
    var reason;
    var dealdate;
    var date;
    var status;
    var res = document.getElementById("accom-change-table");
    axios.get(IpPort+'/getStuChangeDorm', {
        params: {
            sno: User
        }
    })
        .then(function (response) {
            console.log(response.data);
            if (response.data === null) {

                var resHtml = `
                <tr class="active" >
                    <td>
                      无
                    </td>
                    <td>无</td>
                    <td>无</td>
                </tr>
                `;
                res.innerHTML += resHtml;
            }
            else {
                for (let i = 0; i < response.data.length; i++) {
                    date = response.data[i].changedormdate.substr(0, 10);
                    // alert(response.data[i].checkoutdate);
                    // alert(date.toLocaleDateString());
                    dealdate = response.data[i].sdate.substr(0, 10);
                    if (dealdate === null) {
                        dealdate = "未处理";
                    }

                    reason = response.data[i].reason;
                    status = response.data[i].state;
                    if (i % 5 == 0) {
                        var resHtml = `
                <tr class="active" >
                    <td>换宿时间：`+ date + `<br>换宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 1) {
                        var resHtml = `
                <tr class="success" >
                    <td>换宿时间：`+ date + `<br>换宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 2) {
                        var resHtml = `
                <tr class="info" >
                    <td>换宿时间：`+ date + `<br>换宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 3) {
                        var resHtml = `
                <tr class="warning" >
                    <td>换宿时间：`+ date + `<br>换宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 4) {
                        var resHtml = `
                <tr class="danger" >
                    <td>换宿时间：`+ date + `<br>换宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    res.innerHTML += resHtml;
                }
            }
        });
}

function getDormCheckoutInfo() {
    var User = sessionStorage.getItem("CounselorUserName");
    var reason;
    var dealdate;
    var date;
    var status;
    var res = document.getElementById("accom-checkout-table");
    axios.get(IpPort+'/getStuCheckout', {
        params: {
            sno: User
        }
    })
        .then(function (response) {
            // alert(response.data);
            if (response.data === null) {
                var resHtml = `
                <tr class="active" >
                    <td>
                      无
                    </td>
                    <td>无</td>
                    <td>无</td>
                </tr>
                `;
                res.innerHTML += resHtml;
            }
            else {
                for (let i = 0; i < response.data.length; i++) {
                    date = response.data[i].checkoutdate.substr(0, 10);
                    dealdate = response.data[i].sdate.substr(0, 10);
                    if (dealdate === null) {
                        dealdate = "未处理";
                    }
                    reason = response.data[i].reason;
                    status = response.data[i].state;
                    if (i % 5 == 0) {
                        var resHtml = `
                <tr class="active" >
                    <td>退宿时间：`+ date + `<br>退宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 1) {
                        var resHtml = `
                <tr class="success" >
                    <td>退宿时间：`+ date + `<br>退宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 2) {
                        var resHtml = `
                <tr class="info" >
                    <td>退宿时间：`+ date + `<br>退宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 3) {
                        var resHtml = `
                <tr class="warning" >
                    <td>退宿时间：`+ date + `<br>退宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    else if (i % 5 == 4) {
                        var resHtml = `
                <tr class="danger" >
                    <td>退宿时间：`+ date + `<br>退宿原因：` + reason +
                            `</td>
                    <td>`+ dealdate + `</td>
                    <td>`+ status + `</td>
                </tr>
                `;
                    }
                    res.innerHTML += resHtml;
                }
            }
        });
}

// 用于通过id获取元素并打印信息
function showTips(id, msg) {
    var item = document.getElementById(id);
    item.innerHTML = msg;
}

// 个人信息界面：点击提交按钮向后台提交数据(电话和班级)
function personinfo_submit() {
    var sno = sessionStorage.getItem("CounselorUserName");
    var num = document.getElementById("stu-phone").value;
    console.log(num);
    var cla = document.getElementById("stu-class").value;
    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
    axios.defaults.transformRequest = [function (data) {
        let ret = ''
        for (let it in data) {
            ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
        }
        return ret
    }]
    axios.post(IpPort+'/StudentUpdateInfo', {
        sno: sno,
        stel: num,
        sclass: cla
    })
        .then(function (response) {
            alert("提交成功!");
            // console.log(response);
            // // 返回true，登陆成功
            // if (response) {
            //     alert("提交成功!");
            // }
            // else {
            //     alert("提交失败...");
            // }
        })
        .catch(function (error) {
            console.log(error);
        });
}

// 个人信息界面：一开始修改信息的提交键不可按，监听班级和电话内容改变时，才变得可以按
function canSubmit() {
    var sub = document.getElementById("person-info-submit");
    if (checkClass() && checkPhone()) {
        sub.disabled = false;
    }
    else {
        sub.disabled = true;
    }
}

// 个人信息界面：点击重置按钮  设置submit按钮不可点击、电话和班级的help-block清空
function peron_info_reset() {
    var sub = document.getElementById("person-info-submit");
    sub.disabled = true;
    // showTips("help-block-phone", "");
    // showTips("help-block-class", "");

    // document.getElementById('stu-class').value = sessionStorage.getItem("class"); // 班级
    // document.getElementById('stu-phone').value = sessionStorage.getItem("tel"); // 电话
    person_info_loading();
}

// ************************************************ 退宿 换宿 请假界面 **********************

// 加载时，自动显示姓名、学号、原楼栋号、宿舍号
function accom_loading() {
    var User = sessionStorage.getItem("CounselorUserName");
    // alert(User);
    axios.get(IpPort+'/StudentUserInfo', {
        params: {
            sno: User
        }
        // 把User代表的学号发过去，得到该学生的姓名等信息
    })
        .then(function (response) {
            // $('#name1').val('值');
            // document.getElementById('name1').value = '值';
            document.getElementById('stu-id').value = response.data.sno;
            document.getElementById('stu-name').value = response.data.sname;
            document.getElementById('stu-bno').value = response.data.buildings_bno; // 楼栋号
            document.getElementById('stu-dno').value = response.data.dorms_dno; // 宿舍号
        });
}

// 监听退换宿日期不可空，空的话submit不可点击：
// 初始时submit不可点击，监听退换宿日期有值，则变得可以点击
function accom_change() {
    var leavedate = document.getElementById("accom-date").value;
    var submit = document.getElementById("accom-submit");
    if (leavedate !== "") {
        // alert(leavedate);
        submit.disabled = false;
    }
    else {
        submit.disabled = true;
    }
}

// 报修
function repair_change() {
    var repairdate = document.getElementById("repairdate").value;
    var itemname = document.getElementById("itemname").value;
    var reason = document.getElementById("reason").value;
    var submit = document.getElementById("repair-submit");
    if (repairdate !== "" && reason !== "" && itemname !== "") {
        submit.disabled = false;
    }
    else {
        submit.disabled = true;
    }
}

// 创建Date对象，获取当前时间, 返回值是string：yyyy-MM-dd
function getTime() {
    // var myDate = new Date();
    // return myDate.toLocaleDateString().split('/').join('-');
    var nowDate = new Date();
    var year = nowDate.getFullYear();
    var month = nowDate.getMonth() + 1 < 10 ? "0" + (nowDate.getMonth() + 1) : nowDate.getMonth() + 1;
    var day = nowDate.getDate() < 10 ? "0" + nowDate.getDate() : nowDate.getDate();
    var dateStr = year + "-" + month + "-" + day;
    return dateStr;
}

// 提交退宿表，点击时创建Date获取申请时间
function accom_Leavesubmit() {
    var sno = sessionStorage.getItem("CounselorUserName");
    // alert("退宿");
    var checkoutdate = document.getElementById("accom-date").value;
    if (checkoutdate !== "") {
        var sdate = getTime(); // 写的函数，转化成yyyy-MM-dd的日期
        var reason = document.getElementById("accom-reason").value;

        axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
        axios.defaults.transformRequest = [function (data) {
            let ret = ''
            for (let it in data) {
                ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
            }
            return ret
        }]
        axios.post(IpPort+'/postStuCheckout', {
            sno: sno,
            checkoutdate: checkoutdate,
            reason: reason,
            sdate: sdate
        })
            .then(function (response) {
                // alert(response);
                alert("退宿申请提交成功！")
                // 返回true，登陆成功
                // if (response) {
                //     alert("退宿申请提交成功！")
                // }
                // else {
                //     alert("退宿申请提交失败...");
                // }
            })
            .catch(function (error) {
                alert(error);
            });
    }
    else {
        alert("请填写完整信息！")
    }

}

// 提交保修
function repair_submit() {
    var sno = sessionStorage.getItem("CounselorUserName");
    var repairdate = document.getElementById("repairdate").value;
    var itemname = document.getElementById("itemname").value;
    var reason = document.getElementById("reason").value;
    if (repairdate !== "" && reason !== "" && itemname !== "") {
        var sdate = getTime();
        axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
        axios.defaults.transformRequest = [function (data) {
            let ret = ''
            for (let it in data) {
                ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
            }
            return ret
        }]
        axios.post(IpPort+'/postRepairbySno', {
            sno: sno,
            repairdate: repairdate,
            reason: reason,
            sdate: sdate,
            itemname: itemname
        })
            .then(function (response) {
                // alert(response.data);
            })
            .catch(function (error) {
                alert(error);
            });
        alert("退宿申请提交成功！")
    }
    else {
        alert("请填写完整信息！")
    }
}

// 提交换宿表，点击时创建Date获取申请时间
function accom_Changesubmit() {
    var sno = sessionStorage.getItem("CounselorUserName");
    var changedate = document.getElementById("accom-date").value;
    // alert("换宿时间" + changedate);
    if (changedate !== "") {
        var sdate = getTime();
        var reason = document.getElementById("accom-reason").value;
        // alert("当前时间" + sdate);
        // alert(reason);

        axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
        axios.defaults.transformRequest = [function (data) {
            let ret = ''
            for (let it in data) {
                ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
            }
            return ret
        }]
        axios.post(IpPort+'/postStuChangeDorm', {
            sno: sno,
            changedormdate: changedate,
            reason: reason,
            sdate: sdate
        })
            .then(function (response) {
                alert("换宿申请提交成功！")
            })
            .catch(function (error) {
                alert(error);
            });
        // alert("?");
    }
    else {
        alert("请填写完整信息！")
    }

}

// 退换宿的reset
function accom_reset() {
    document.getElementById("accom-date").value = "";;
    document.getElementById("accom-reason").value = "";
}

// 监听请假中的离返校日期及原因不可空，空的话submit不可点击：
function leave_change() {
    var leavedate = document.getElementById("leave-leavedate").value;
    var returndate = document.getElementById("leave-returndate").value;
    var reason = document.getElementById("leave-reason").value;
    var submit = document.getElementById("leave-submit");
    if (leavedate !== "" && returndate !== "" && reason !== "") {
        // alert(leavedate);
        submit.disabled = false;
    }
    else {
        submit.disabled = true;
    }
}

// 请假表中的reset: 离返校日期、请假原因重置
function leave_reset() {
    document.getElementById("leave-leavedate").value = "";
    document.getElementById("leave-returndate").value = "";
    document.getElementById("leave-reason").value = "";
}

// 提交请假表
// 离开宿舍leavedate、 预计回宿舍的日期：backdate申请原因reason、申请日期sdate
function leave_submit() {
    var User = sessionStorage.getItem("CounselorUserName");
    var leavedate = document.getElementById("leave-leavedate").value;
    var returndate = document.getElementById("leave-returndate").value;
    var reason = document.getElementById("leave-reason").value;
    if (leavedate !== "" && returndate !== "" && reason !== "") {
        var date = getTime();

        axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
        axios.defaults.transformRequest = [function (data) {
            let ret = ''
            for (let it in data) {
                ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
            }
            return ret
        }]
        axios.post(IpPort+'/postStuLeave', {
            sno: User,
            leavedate: leavedate,
            backdate: returndate,
            reason: reason,
            sdate: date

        })
            .then(function (response) {
                // alert(response.data);
                // 返回true，登陆成功
                if (response.data) {
                    alert("请假申请提交成功！")
                }
                else {
                    alert("请假申请提交失败...");
                }
            })
            .catch(function (error) {

                console.log(error.response.data);
            });
    }
    else {
        document.getElementById("leave-submit").disabled = true;
    }

}

// **************************** 信息校验 ***************************

// 个人信息界面：校验电话
function checkPhone() {
    var number = document.getElementById("stu-phone").value;
    var check = /[0-9]{11}/;
    if (!check.test(number)) {
        showTips("help-block-phone", "请输入有效的11位电话号码");
        return false;
    }
    else {
        showTips("help-block-phone", "");
        return true;
    }
}

// 个人信息校验：校验班级不能为空
function checkClass() {
    var cla = document.getElementById("stu-class").value;
    if (cla === "") {
        showTips("help-block-class", "请输入有效的班级");
        return false;
    }
    else {
        showTips("help-block-class", "");
        return true;
    }
}

// *********************** 修改密码 ************************
function changePassSubmit() {
    var passOldUser = document.getElementById("pass-old").value
    // var passOld = sessionStorage.getItem("Pass")
    var pass = document.getElementById("pass").value
    var passCon = document.getElementById("confirm-pass").value
    var sno = sessionStorage.getItem("CounselorUserName");

    if (passOldUser !== "" && pass !== "" && passCon != "") {
        // 不能为空
        if (pass === passCon) {
            // 原密码与新密码一致
            if (pass === passOldUser) {
                showTips("help-block-pass", "原密码与新密码填写一致！请修改新密码。");
            }
            else {
                // 密码强度校验
                // 1、如果输入的密码为单纯的数字或者字母：提示“低”
                // 2、如果是数字和字母混合的：提示“中”
                // 3、如果数字、字母、特殊字符都有：提示“强”
                if (pass.match(/(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).{8,20}/)) {
                    // 加密：
                    var codePassOld = md5(passOldUser)
                    alert("旧密码" + codePassOld)
                    alert(pass)
                    var codePass = md5(pass);
                    // 发送请求
                    // alert("passOldUser" + passOldUser)
                    // alert("pass" + pass)
                    // alert("passCon" + passCon)
                    axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
                    axios.defaults.transformRequest = [function (data) {
                        let ret = ''
                        for (let it in data) {
                            ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
                        }
                        return ret
                    }]
                    axios.post(IpPort+'/updatePassword', {
                        uno: sno,
                        oldpass: codePassOld,
                        newpass: codePass
                    })
                        .then(function (response) {
                            console.log(response.data);
                            if (response.data) {
                                alert("修改成功!");
                                changePassCancel();
                            }
                            else {
                                alert("旧密码填写错误，修改失败...");
                            }
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                }
                else {
                    showTips("help-block-pass", "密码必须包含8~20位数字、字母、特殊字符！")
                }
            }

        }
        else {
            showTips("help-block-pass", "确认密码不一致！");
        }
    }
    else {
        showTips("help-block-pass", "请填写完整信息！");
    }


}


function changePass() {
    showTips("help-block-pass", "");
    document.getElementById("pass-old").value = "";
    document.getElementById("pass").value = "";
    document.getElementById("confirm-pass").value = "";
    document.getElementById("changePassDiv").style.display = "block";
    document.getElementById("changePassBtnDiv").style.display = "none";
}

function changePassCancel() {
    document.getElementById("changePassDiv").style.display = "none";
    document.getElementById("changePassBtnDiv").style.display = "flex";
}