function [gfit, bestfit, hout] = fitThicknessDistribution(thicknessA)
            [hN, edges] = histcounts(thicknessA(1,:));
            edges=edges+0.5*(edges(1,2)-edges(1,1));
            edges = edges(1,1:end-1);
            hout = [edges; hN];
            meant = mean(thicknessA(1,:));
            sdtt = std(thicknessA(1,:));
            maxN = max(hN);
            options = fitoptions('gauss1');
            options.StartPoint = [maxN, meant, sdtt];
            gfit = fit(edges',hN','gauss1',options);
            edgesF = [edges(1,1):0.1:edges(1,end)];
            y = feval(gfit,edgesF);
            bestfit = [edgesF;y'];
end
