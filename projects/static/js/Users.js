function handle(){

		 $("button[event=upd]").on("click", (e)=>{

        $.ajax({
            url: "//projects/users/info",
            type: "GET",
            async: false,
            data:{
                id: $(e.target).attr("data"),
            },
            success: function(res){
                    res = JSON.parse(res);
                if(res.code == 0){

                    $.initForm("updForm", res.data);
                    $.model(".updWin");
                }else{
                    $.msg("error", res.msg);
                }
            }
        });
    });

    $("button[event=del]").on("click", (e)=>{

        $.confirm("确认要删除吗", () =>{

            $.ajax({
                url: "//projects/users/del",
                type: "POST",
                async: false,
                data:{
                    id: $(e.target).attr("data"),
                },
                success: function(res){
                    res = JSON.parse(res);
                    if(res.code == 0){
                        $.alert(res.msg, () =>{

                            window.location.reload();
                        });
                    }else{
                        $.msg("error", res.msg);
                    }
                }
            });
        });
    });
}

$(function (){

    let tableView =  {
        el: "#tableShow",
        url: "//projects/users/page",
        method: "GET",
        where: {
            pageIndex: 1,
            pageSize: 10
        },
        page: true,
        cols: [
            {
                type: "number",
                title: "序号",
            },
            			{
				field: "userName",
				title: "用户账号",
				align: "center",
			},
									{
				field: "passWord",
				title: "用户密码",
				align: "center",
			},
									{
				field: "name",
				title: "用户姓名",
				align: "center",
			},
									{
				field: "age",
				title: "用户年龄",
				align: "center",
			},
									{
				field: "gender",
				title: "用户性别",
				align: "center",
			},
									{
				field: "type",
				title: "用户身份",
				align: "center",
			},
						            {
                title: "操作",
                template: (d)=>{

                    return `
                            <button type="button" event="upd" data="d.id" class="fater-btn fater-btn-primary fater-btn-sm">
                                <span data="d.id" class="fa fa-edit"></span>
                            </button>
                            <button type="button" event="del" data="d.id" class="fater-btn fater-btn-danger fater-btn-sm">
                                <span data="d.id" class="fa fa-trash"></span>
                            </button>
                            `;
                }
            }
        ]
    }
    $.table(tableView);

    $(".fater-btn-form-qry").on("click", ()=>{

        tableView.where["name"] = $("[name=para1]").val();

        $.table(tableView);
        
        handle();
    });

    $("button[event=add]").on("click", ()=>{

        $.model(".addWin");
    });
    

		handle();

    $("#addFormBtn").on("click", ()=>{

        let formVal = $.getFrom("addForm");

        $.ajax({
            url: "//projects/users/add",
            type: "POST",
            data: formVal,
            success: function(res){
                    res = JSON.parse(res);
                if(res.code == 0){
                    $.alert(res.msg, () =>{

                        window.location.reload();
                    });
                }else{
                    $.msg("error", res.msg);
                }
            }
        });
    });

    $("#updFormBtn").on("click", ()=>{

        let formVal = $.getFrom("updForm");

        $.ajax({
            url: "//projects/users/upd",
            type: "POST",
            data: formVal,
            success: function(res){
                    res = JSON.parse(res);
                if(res.code == 0){
                    $.alert(res.msg, () =>{

                        window.location.reload();
                    });
                }else{
                    $.msg("error", res.msg);
                }
            }
        });
    });
});