<!DOCTYPE>

<html ng-app="graphApp">

<head>
    <title>CF2 - Graph Queue Visualization </title>

    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>

    <script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
    <script src="http://cytoscape.github.io/cytoscape.js/api/cytoscape.js-latest/cytoscape.min.js"></script>

    <!-- for testing with local version of cytoscape.js -->
    <!--<script src="../cytoscape.js/build/cytoscape.js"></script>-->

    <script src="https://cdn.rawgit.com/cpettitt/dagre/v0.7.4/dist/dagre.min.js"></script>
    <script src="https://cdn.rawgit.com/cytoscape/cytoscape.js-dagre/1.1.2/cytoscape-dagre.js"></script>

    <style>
        body {
            font-family: helvetica;
            font-size: 14px;
        }

        #cy {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            z-index: 999;
        }

        h1 {
            opacity: 0.5;
            font-size: 1em;
        }
    </style>

    <script>


        var graphApp = angular.module('graphApp', []);
        graphApp.controller('GraphDrawCtrl', function ($scope, $http){
            $http.get('gOneRecord.JSON').success(function(graphRawRecords) {
                $scope.jsonData=graphRawRecords;

                console.log("Welcome");
                console.log($scope.jsonData);

                // Creating Graph JSON object as per examples
                $scope.elements={}
                $scope.edge={};
                $scope.edges=[];
                $scope.nodes=[];

                /*
                    Creation of Graph Edges as per below
                    edges: [{ data: { source: 'n0', target: 'n1' } } ]
                 */
                for(var i=0;i< $scope.jsonData.edgeList.length;i++){
                    $scope.edgeRecord={};
                    $scope.datas={};
                    $scope.edgeRecord.target=$scope.jsonData.edgeList[i].inVertexId;
                    $scope.edgeRecord.source=$scope.jsonData.edgeList[i].outVertexId;
                    $scope.datas.data=$scope.edgeRecord;
                    $scope.edges.push($scope.datas);
                }

                /*
                    Creation of Graph Nodes as per below
                    nodes: [{ data: { id: 'n0' } }]
                 */
                for(var i=0;i< $scope.jsonData.vertexList.length;i++){
                    $scope.nodeRecord={};
                    $scope.datas1={};
                    $scope.nodeRecord.id=$scope.jsonData.vertexList[i].id;
                    $scope.datas1.data=$scope.nodeRecord;
                    $scope.nodes.push($scope.datas1);
                }

                // adding Nodes and Edges in Eelements JSON
                $scope.elements.nodes=$scope.nodes;
                $scope.elements.edges=$scope.edges;

                console.log($scope.elements);


                    var cy = window.cy = cytoscape({
                        container: document.getElementById('cy'),

                        boxSelectionEnabled: false,
                        autounselectify: true,

                        layout: {
                            name: 'dagre'
                        },

                        style: [
                            {
                                selector: 'node',
                                style: {
                                    'content': 'data(id)',
                                    'text-opacity': 0.5,
                                    'text-valign': 'left',
                                    'text-halign': 'right',
                                    'background-color': '#11479e'
                                }
                            },

                            {
                                selector: 'edge',
                                style: {
                                    'width': 4,
                                    'target-arrow-shape': 'triangle',
                                    'line-color': 'green',
                                    'target-arrow-color': 'green',
                                    'curve-style': 'bezier'
                                }
                            }
                        ],

                        elements: $scope.elements

                });

            });

            });


    </script>
</head>



</body>
<body ng-controller="GraphDrawCtrl">
<div id="cy"></div>
</body>
</html>
