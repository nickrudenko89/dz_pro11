<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <style>
        .buttonInput {
            width: 50px;
            height: 50px;
        }
        .textInput {
            width: 211px;
            height: 35px;
            text-align: right;
            font-size: x-large;
        }
    </style>
    <title>Калькулятор</title>
    <script>
        function typeElement (id,value) {
            if(id==0 || id==1) {
                document.getElementById('resultInput').value = 0;
                return;
            }
            else if(id==2) {
                var inputValue = document.getElementById('resultInput').value;
                if (inputValue.length>1)
                    document.getElementById('resultInput').value = inputValue.substring(0,inputValue.length-1);
                else
                    document.getElementById('resultInput').value = 0;
            }
            else if((id >= 3 && id <= 15) || id == 17) {
                if (document.getElementById('resultInput').value == 0)
                    document.getElementById('resultInput').value = value;
                else
                    document.getElementById('resultInput').value += value;
            }
            else if(id==19)
                window.location.replace("/");
        }
    </script>
</head>
<body>

    <c:if test="${expressionResult==null}">
        <c:set var="textInputValue" value="0"/>
    </c:if>
    <c:if test="${expressionResult!=null}">
        <c:set var="textInputValue" value="${expressionResult}"/>
    </c:if>

    <table>
    <tr><td colspan="4"><input class="textInput" id="resultInput" type="text" value="${textInputValue}"/></td></tr>
    <tr>
    <c:set var="counter" value="0"/>
    <c:forEach var="item" items="CE,C,←,/,7,8,9,*,4,5,6,-,1,2,3,+,±,0,.,=">
        <td>
            <input class="buttonInput" type="button" id="${counter}" value="${item}" onclick="typeElement(${counter},'${item}')"/>
        </td>
        <c:if test="${(counter+1)%4==0}">
            </tr>
            <tr>
        </c:if>
        <c:set var="counter" value="${counter+1}"/>
    </c:forEach>
    </tr>
</table>

</body>
</html>
