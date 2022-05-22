<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/echarts@5.3.1/dist/echarts.min.js" integrity="sha256-up/VQ00XWfwfCN9hDtxDmZk9PgDVs83dQvTPRnWK0p4=" crossorigin="anonymous"></script>
<link href="../resources/css/commons.css" rel="stylesheet">

<style>
.bg-dashboard {background-color: #fafafaa0}

.txt{
    width: 4rem;
    height: 2.594rem;
    line-height: 50px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;      
}


</style>

<script>

	function loadChartData() {
		var xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = JSON.parse(xhr.responseText);
				
				drawChart0(data.totalProportion);
				drawChart0_1(data.totalProportion);
				drawChart1(data.totalProportion);
				drawChart2(data.officeProportion);
				drawChart3(data.officeProportion);
			}			
		};		
		
		xhr.open("GET" , "./loadChartData", true);
		xhr.send();

	}
	
	function drawChart0(data) {
		
		var root = document.querySelector("#chart0Box");
		var chart0Main = document.createElement("div");
		chart0Main.setAttribute("class", "rounded-10 pt-11 ms-1");
		chart0Main.setAttribute("style", "width: 20rem;height:20rem; font-size:.813rem; padding-top:2rem; background-color:#ffffff89");
		
		root.appendChild(chart0Main);
		
		var chart0 = echarts.init(chart0Main);
		
		var totalProportion = parseInt(data.totalProportion);
		if(totalProportion > 100) {			
			totalProportion = 100;			
		}	
		
		option = {
			  title: {
				    text: '내 전체 오피스 누적 예약율',
				    top:'top',
				    left:'center'
				  },
		  	series: [
		    	{
		        type: 'gauge',
		        axisLine: {
		          lineStyle: {
		            width: 30,
		            color: [
		              [0.3, '#67e0e3'],
		              [0.7, '#37a2da'],
		              [1, '#fd666d']
		            ]
		          }
		        },
		      pointer: {
		        itemStyle: {
		          color: 'auto'
		        }
		      },
		      axisTick: {
		        distance: -30,
		        length: 8,
		        lineStyle: {
		          color: '#fff',
		          width: 2
		        }
		      },
		      splitLine: {
		        distance: -30,
		        length: 30,
		        lineStyle: {
		          color: '#fff',
		          width: 4
		        }
		      },
		      axisLabel: {
		        color: 'auto',
		        distance: 35,
		        fontSize: 10
		      },
		      detail: {
		        valueAnimation: true,
		        formatter: '{value} ％',
		        color: 'auto',
		        fontSize: 18
		      },
		      data: [
		        {
		          value: totalProportion
		        }
		      ]
		    }
		  ]
		};		
		
		chart0.setOption(option);	
	}
	
	function drawChart0_1(data) {
		
		var root = document.querySelector("#chart0_1Box");		
		var chart0_1Main = document.createElement("div");
		chart0_1Main.setAttribute("class", "rounded-10 ms-1");
		chart0_1Main.setAttribute("style", "width: 20rem;height:22rem; font-size:.813rem; background-color:#ffffff89; padding-top: 2.75rem");
		
		root.appendChild(chart0_1Main);
		
		var chart0_1 = echarts.init(chart0_1Main);
		
		option = {
		  title: {
			    text: '내 전체 오피스 누적 수익',
			    left:'center'
			  },				
		  series: [
		    {
		      top:'50%',
		      type: 'gauge',
		      startAngle: 180,
		      endAngle: 0,
		      min: 0,
		      max: 1,
		      splitNumber: 8,
		      axisLine: {
		        lineStyle: {
		          width: 6,
		          color: [
		            [0.25, '#FF6E76'],
		            [0.5, '#FDDD60'],
		            [0.75, '#58D9F9'],
		            [1, '#7CFFB2']
		          ]
		        }
		      },
		      pointer: {
		        icon: 'path://M12.8,0.7l12,40.1H0.7L12.8,0.7z',
		        length: '12%',
		        width: 20,
		        offsetCenter: [0, '-50%'],
		        itemStyle: {
		          color: 'auto'
		        }
		      },
		      axisTick: {
		        length: 12,
		        lineStyle: {
		          color: 'auto',
		          width: 2
		        }
		      },
		      splitLine: {
		        length: 20,
		        lineStyle: {
		          color: 'auto',
		          width: 5
		        }
		      },
		      axisLabel: {
		        color: '#464646',
		        fontSize: 12,
		        distance: -45,
		        formatter: function (value) {
		          if (value === 0.875) {
		            return 'A';
		          } else if (value === 0.625) {
		            return 'B';
		          } else if (value === 0.375) {
		            return 'C';
		          } else if (value === 0.125) {
		            return 'D';
		          }
		          return '';
		        }
		      },
		      title: {
		        offsetCenter: [0, '-20%'],
		        fontSize: 15
		      },
		      detail: {
		        fontSize: 30,
		        offsetCenter: [0, '70%'],
		        valueAnimation: true,
		        formatter: function (value) {
		          return '총 수익\n￦ ' + (value*1000000).toLocaleString() + '원';
		        },
		        color: 'auto'
		      },
		      data: [
		        {
		          value: (data.totalPrice) / 1000000,
		          name: 'Guage'
		        }
		      ]
		    }
		  ]
		};
		
		chart0_1.setOption(option);			
	}	

	function drawChart1(data) {
		
		var root = document.querySelector("#chart1Box");
		var chart1Main = document.createElement("div");
		chart1Main.setAttribute("style", "width: 20rem;height:22rem; font-size:.813rem");
		
		root.appendChild(chart1Main);
		
		var chart1 = echarts.init(chart1Main);
		
		
		var dataList = [];
		for(var officeProportion of data.officeProportionList) {
			var map = {};
			map["value"] = officeProportion.cnt;
			map["name"] = officeProportion.office_name;
			dataList.push(map);
		}
		
		option = {
				  tooltip: {
					    trigger: 'item'
				 },
				  legend: {
					    top: '5%',
					    left: 'center'
				  },
				  series: [
				    {
				      name: 'RentalProportion',
				      type: 'pie',
				      top: '8%',
				      radius: ['40%', '70%'],
				      data: dataList,
				      emphasis: {
				          itemStyle: {
				            shadowBlur: 10,
				            shadowOffsetX: 0,
				            shadowColor: 'rgba(0, 0, 0, 0.5)'
				          }
				      }
				    }
				  ]
				};
		
		chart1.setOption(option);
	}
	
	function drawChart2(data) {
		
		var root = document.querySelector("#chart2Box");
		var chart2Main = document.createElement("div");
		chart2Main.setAttribute("style", "width: 20rem;height:22rem; font-size:.813rem");
		
		root.appendChild(chart2Main);
		
		var chart2 = echarts.init(chart2Main);
		
		var yAxisList = [];
		var seriesList = [];
		var cnt = 0;
		
		for(var d of data) {
			var dataList = [];
			var map = {};
			var office_name = null;
			map["type"] = "bar";
			map["stack"] = "total";
			map["label"] = {show: true};
			map["emphasis"] = {focus: "series"};
			
			for(var dr of d.rentalProportion) {
				if(cnt < 5) {
					yAxisList.push(dr.period);
					cnt++;
				}				
								
				office_name = dr.office_name;

				dataList.push(dr.cnt);
			}
			dataList.reverse();
			map["name"] = office_name;
			map["data"] = dataList;
			seriesList.push(map);
		}
		
		yAxisList.reverse();
		option = {
				  tooltip: {
				    trigger: 'axis',
				    axisPointer: {
				      // Use axis to trigger tooltip
				      type: 'shadow' // 'shadow' as default; can also be 'line' or 'shadow'
				    }
				  },
				  legend: {},
				  grid: {
				    left: '3%',
				    right: '4%',
				    bottom: '3%',
				    containLabel: true
				  },
				  xAxis: {
				    type: 'value'
				  },
				  yAxis: {
				    type: 'category',
				    data: yAxisList
				  },
				  series: seriesList
				};				
		
		chart2.setOption(option);
	}	
	
	function drawChart3(data) {
		
		var root = document.querySelector("#chart3Box");
		var chart3Main = document.createElement("div");
		chart3Main.setAttribute("style", "width: 20rem;height:22rem; font-size:.813rem");
		
		root.appendChild(chart3Main);
		
		var chart3 = echarts.init(chart3Main);
		
		var xAxisList = [];
		var legend = [];
		var seriesList = [];
		var cnt = 0;
		
		for(var d of data) {
			var dataList = [];
			var map = {};
			var office_name = null;
			map["type"] = "line";
			
			var flag = true;
			for(var dr of d.rentalProportion) {
				if(cnt < 5) {
					xAxisList.push(dr.period.slice(2,dr.period.length));
					cnt++;
				}				
				
				if(flag) {
					legend.push(dr.office_name);
					flag = false;
				}
				
				office_name = dr.office_name;

				dataList.push(dr.totalPrice);
			}
			//dataList.reverse();
			map["name"] = office_name;
			map["data"] = dataList;
			map["smooth"]= true;
			seriesList.push(map);
		}

		//xAxisList.reverse();		
		
		option = {
				  tooltip: {
				    trigger: 'axis'
				  },
				  legend: {
				    data: legend
				  },
				  grid: {
				    left: '3%',
				    right: '4%',
				    bottom: '3%',
				    containLabel: true
				  },
				  xAxis: {
				    type: 'category',
				    boundaryGap: false,
				    data: xAxisList
				  },
				  yAxis: {
				    type: 'value'
				  },
				  series: seriesList
				};		
		
		chart3.setOption(option);
	}	
	
	window.addEventListener("DOMContentLoaded", function() {
		loadChartData();
	});


</script>

</head>
<body>
<div class="container-fluid px-0" style="overflow-x : hidden">
<jsp:include page="../commons/navbar.jsp"></jsp:include>

<div class="row" style="padding-top: 2em; border-top:0.063rem solid #A68A64; border-bottom: 0.063rem solid #A68A64; background-color:rgb(45, 45, 45)">
	<div class="col ms-4 me-4">
		<div class="row">
			<div class="col ms-2 text-gold bold text-fs-30 fst-italic KOHIBaeumOTF pt-2" style="border-left:4px solid #A68A64">Dash board</div>
		</div>
		
		<div class="row rounded-10 bg-dashboard mt-4">
			<div class="col">
				<div class="row px-10" style="padding-top:2rem; padding-bottom:2rem;">
					<div class="col">
						<div class="text-fs-23 block"><i class="bi bi-calculator text-gold text-center ms-4"></i> 오피스 평균 평점</div>
						<i class="bi bi-star-fill ms-4 ps-3" style="color: #d49d4c; font-size:2.75rem"></i>
						<span class="text-center pl-1" style="font-size:2.75rem">${reviewAvg}</span>					
					</div>					
				</div>
			</div>
		</div>		
		<div class="row rounded-10 bg-dashboard mt-4">
			<div class="col">
				<div class="row pt-6">
					<div class="col">
						<div class="row">
							<div class="col">
								<span class="col text-fs-18 font-medium ms-2"><i class="bi bi-diagram-3 text-gold"></i> 총 예약율</span>
								<span class="col text-gray-c_3c text-fs-11">등록일로부터 현재</span>							
							</div>	
						</div>
						<div class="row mt-3 mb-3">
							<div id="chart0Box" class="col"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>
		<div class="row rounded-10 bg-dashboard mt-4">
			<div class="col">
				<div class="row pt-6">
					<div class="col">
						<div class="row">
							<div class="col">
								<span class="col text-fs-18 font-medium ms-2"><i class="bi bi-coin text-gold"></i> 총 수익</span>
								<span class="col text-gray-c_3c text-fs-11">등록일로부터 현재</span>							
							</div>	
						</div>
						<div class="row mt-3 mb-3">
							<div id="chart0_1Box" class="col"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>							
		<div class="row rounded-10 bg-dashboard mt-4">
			<div class="col">
				<div class="row pt-6">
					<div class="col">
						<div class="row">
							<div class="col">
								<span class="col text-fs-18 font-medium ms-2"><i class="bi bi-pie-chart text-gold"></i> 전체 예약율</span>
								<span class="col text-gray-c_3c text-fs-11">등록일로부터 현재</span>							
							</div>	
						</div>
						<div class="row">
							<div id="chart1Box" class="col"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>
		<div class="row rounded-10 bg-dashboard mt-4">
			<div class="col">
				<div class="row pt-6">
					<div class="col">
						<div class="row">
							<div class="col">
								<span class="col text-fs-18 font-medium ms-2 me-5"><i class="bi bi-exclamation-triangle text-gold"></i> 최근 안 좋은 리뷰</span>
								<span class="text-right text-fs-13 ms-5 cursor-pointer">더보기 <i class="bi bi-chevron-right cursor-pointer"></i></span>					
							</div>	
						</div>
						<div class="row mt-3 mb-3">
							<div id="badReviewBox" class="col ms-4 me-4 py-3 rounded-5" style="background-color:#ffffff89">
								<c:forEach items="${negativeReview }" var="review">
									<div class="row mb-1 ms-2 text-fs-12">
										<div class="col-2"><i class="bi bi-star-fill" style="color:#d49d4c;"></i> ${review.review_rating }</div>
										<div class="col-4">${review.office_name }</div>										
										<c:choose>
											<c:when test="${fn:length(review.review_title) > 10 }">
												<div class="col cursor-pointer text-red-soft" onclick="location.href='../guest/officeReviewDetailPage?review_no=${review.review_no}'">${fn:substring(review.review_title,0,10) }..</div>	
											</c:when>
											<c:otherwise>
												<div class="col cursorpointer text-red-soft" onclick="location.href='../guest/officeReviewDetailPage?review_no=${review.review_no}'">${review.review_title }</div>
											</c:otherwise>
										</c:choose>
										
									</div>																
								</c:forEach>							
							</div>
						</div>						
					</div>					
				</div>
			</div>
		</div>
		<div class="row rounded-10 bg-dashboard mt-4">
			<div class="col">
				<div class="row pt-6">
					<div class="col">
						<div class="row">
							<div class="col">
								<span class="col text-fs-18 font-medium ms-2"><i class="bi bi-bar-chart-line text-gold"></i> 오피스별 예약</span>
								<span class="col text-gray-c_3c text-fs-11">최근 5개월</span>							
							</div>	
						</div>
						<div class="row mt-3 mb-3">
							<div id="chart2Box" class="col"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>	
		<div class="row rounded-10 bg-dashboard mt-4" style="margin-bottom:4rem">
			<div class="col">
				<div class="row pt-6">
					<div class="col">
						<div class="row">
							<div class="col">
								<span class="col text-fs-18 font-medium ms-2"><i class="bi bi-graph-up-arrow text-gold"></i> 오피스별 수익</span>
								<span class="col text-gray-c_3c text-fs-11">최근 5개월</span>							
							</div>	
						</div>
						<div class="row mt-3 mb-3">
							<div id="chart3Box" class="col"></div>
						</div>
					</div>					
				</div>
			</div>
		</div>								
	</div>
</div>



<jsp:include page="../commons/footer.jsp"></jsp:include>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>